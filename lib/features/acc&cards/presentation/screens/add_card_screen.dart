import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/functions/validation.dart';
import 'package:ibank/core/model/card_model.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/core/widgets/input_field_widget.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_cubit.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_states.dart';

class AddCardScreen extends StatefulWidget {
  AddCardScreen({super.key});
  final TextEditingController? cardNumberController = TextEditingController();

  final TextEditingController? cardHolderNameController =
      TextEditingController();

  final TextEditingController? expirationDateController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccCardCubit>(
      create: (context) => AccCardCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Card', style: getTitle2TextStyle()),
        ),
        body: Form(
          key: widget._formKey,
          child: BlocConsumer<AccCardCubit, AccCardStates>(
            listener: (context, state) {
              if (state is AddCardSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColours.semanticColor4,
                    content: Text(state.message),
                  ),
                );
                Navigator.pop(context);
              } else if (state is AddCardErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColours.semanticColor1,
                    content: Text(state.error),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Card Number', style: getCaption1TextStyle()),
                    const SizedBox(height: 10.0),
                    InputFieldWidget(
                      hint: 'Enter Card Number',
                      keyboardType: TextInputType.number,
                      controller: widget.cardNumberController,
                      validator: (value) {
                        return creditCardNumberValid(value);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Text('Card Holder Name', style: getCaption1TextStyle()),
                    const SizedBox(height: 10.0),
                    InputFieldWidget(
                      hint: 'Enter Card Holder Name',
                      keyboardType: TextInputType.text,
                      controller: widget.cardHolderNameController,
                    ),
                    const SizedBox(height: 10.0),
                    Text('Expiration Date', style: getCaption1TextStyle()),
                    const SizedBox(height: 10.0),
                    InputFieldWidget(
                      hint: 'MM/YY',
                      dateyearpicker: true,
                      controller: widget.expirationDateController,
                    ),
                    const Spacer(),
                    CustomButtonWidget(
                      text: 'Add Card',
                      onPressed: () {
                        if (widget._formKey.currentState!.validate()) {
                          final cardNumber =
                              widget.cardNumberController!.text.trim();
                          final cardHolderName =
                              widget.cardHolderNameController!.text
                                  .toUpperCase()
                                  .trim();
                          final expirationDate =
                              widget.expirationDateController!.text.trim();
                          final CardModel newCard = CardModel(
                            cardnumber: cardNumber,
                            cardholdername: cardHolderName,
                            expirationdate: expirationDate,
                          );
                          context.read<AccCardCubit>().addCard(newCard);
                        }
                      },
                      bgcolor: AppColours.primaryColor1,
                      textColor: AppColours.naturalColor6,
                      height: 50.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
