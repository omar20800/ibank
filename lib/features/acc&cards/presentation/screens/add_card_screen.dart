import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/functions/validation.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/core/widgets/input_field_widget.dart';
import 'package:ibank/features/acc&cards/data/models/request/card_request.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/add_card_cubit.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/add_card_states.dart';
import 'package:ibank/features/acc&cards/presentation/screens/accountcard_screen.dart';
import 'package:ibank/features/main/presentation/screens/main_screen.dart';

class AddCardScreen extends StatefulWidget {
  AddCardScreen({super.key});
  final TextEditingController? cardNumberController = TextEditingController();

  final TextEditingController? cardHolderNameController =
      TextEditingController();

  final TextEditingController? expirationDateController =
      TextEditingController();

  final TextEditingController? cvvController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCardCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Card', style: getTitle2TextStyle()),
        ),
        body: Form(
          key: widget._formKey,
          child: BlocConsumer<AddCardCubit, AddCardStates>(
            listener: (context, state) {
              if (state is AddCardLoadingState) {
                Dialogs.showLoadingDialog(context);
              } else if (state is AddCardSuccessState) {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                context.pushAndRemoveUntil(MainScreen());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColours.semanticColor4,
                    content: Text(state.message),
                  ),
                );
              } else if (state is AddCardErrorState) {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                Dialogs.showErrorDialog(context, state.error);
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expiration Date',
                                style: getCaption1TextStyle(),
                              ),
                              const SizedBox(height: 10.0),
                              InputFieldWidget(
                                hint: 'MM/YY',
                                dateyearpicker: true,
                                controller: widget.expirationDateController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CVV', style: getCaption1TextStyle()),
                              const SizedBox(height: 10.0),
                              InputFieldWidget(
                                hint: 'Enter CVV',
                                keyboardType: TextInputType.number,
                                controller: widget.cvvController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomButtonWidget(
                      text: 'Add Card',
                      onPressed: () {
                        if (widget._formKey.currentState!.validate()) {
                          final cardNumber =
                              widget.cardNumberController!.text
                                  .replaceAll(' ', '')
                                  .replaceAll('-', '')
                                  .trim();
                          final cardHolderName =
                              widget.cardHolderNameController!.text
                                  .toUpperCase()
                                  .trim();
                          final expirationDate =
                              widget.expirationDateController!.text.trim();
                          final cvv =
                              widget.cvvController!.text.substring(0, 3).trim();
                          final CardRequest newCard = CardRequest(
                            cardNumber: cardNumber,
                            cardHolderName: cardHolderName,
                            expiryDate: expirationDate,
                            cvv: cvv,
                          );
                          context.read<AddCardCubit>().addCard(newCard);
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
