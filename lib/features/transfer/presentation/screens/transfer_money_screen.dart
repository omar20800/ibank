import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/core/widgets/custom_dropdown_button.dart';
import 'package:ibank/core/widgets/input_field_widget.dart';
import 'package:ibank/features/acc&cards/data/models/response/get_cards_response/datum.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_cubit.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_states.dart';
import 'package:ibank/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:ibank/features/transfer/presentation/cubit/transfer_states.dart';

class TransferMoney extends StatefulWidget {
  const TransferMoney({super.key});

  @override
  State<TransferMoney> createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  final TextEditingController amountToTransferController =
      TextEditingController();

  final TextEditingController receiverEmailController = TextEditingController();

  String? selectedMethod;

  bool useBalance = false;

  List<Datum> cards = [];

  List<DropdownMenuItem<String>> methods = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TransferCubit()),
        BlocProvider(create: (context) => AccCardCubit()..getCards()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            'Transfer Money',
            style: getTitle2TextStyle(color: AppColours.textColor),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<AccCardCubit, AccCardStates>(
              listener: (context, state) {
                if (state is GetCardsSuccessState) {
                  cards = state.cards;
                  methods =
                      cards
                          .map(
                            (card) => DropdownMenuItem<String>(
                              value: card.cardNumber,
                              child: Text(
                                '${card.cardHolderName} - ${card.brand} - Ends with ${card.cardNumber?.substring(12, 16)}',
                              ),
                            ),
                          )
                          .toList();
                } else if (state is GetCardsErrorState) {
                  Dialogs.showErrorDialog(context, state.error);
                } else if (state is AccCardLoadingState) {
                  Dialogs.showLoadingDialog(context);
                }
              },
            ),
            BlocListener<TransferCubit, TransferStates>(
              listener: (context, state) {
                if (state is TransferSuccess) {
                  context.pop();
                  Dialogs.showSuccessSnackbar(context, 'Transfer Successful');
                  context.pop();
                } else if (state is TransferError) {
                  context.pop();
                  Dialogs.showErrorDialog(context, state.errorMessage);
                } else if (state is TransferLoading) {
                  Dialogs.showLoadingDialog(context);
                }
              },
            ),
          ],
          child: BlocBuilder<AccCardCubit, AccCardStates>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputFieldWidget(
                        hint: 'Enter Amount to Transfer',
                        controller: amountToTransferController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20.h),
                      InputFieldWidget(
                        hint: 'Enter The Receiver\'s Account Email',
                        controller: receiverEmailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: AppColours.primaryColor1,
                            value: useBalance ? true : false,
                            onChanged: (value) {
                              if (value == true) {
                                selectedMethod = null;
                                useBalance = true;
                                setState(() {});
                              } else {
                                selectedMethod = null;
                                useBalance = false;
                                setState(() {});
                              }
                              (context as Element).markNeedsBuild();
                            },
                          ),
                          Text(
                            'Use Balance',
                            style: getBody1TextStyle(
                              color: AppColours.textColor,
                            ),
                          ),
                        ],
                      ),
                      CustomDropdownButton(
                        enabled: !useBalance,
                        customValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a payment method';
                          }
                          return null;
                        },
                        hint: 'Select Payment Method',
                        methods: methods,
                        onChanged: (value) {
                          selectedMethod = value;
                        },
                      ),
                      SizedBox(height: 40.h),
                      CustomButtonWidget(
                        text: 'Transfer',
                        onPressed: () {
                          if (useBalance) {
                            BlocProvider.of<TransferCubit>(
                              context,
                            ).transferMoney(
                              receiverEmail: receiverEmailController.text,
                              amount: int.parse(
                                amountToTransferController.text,
                              ),
                              usebalance: true,
                            );
                          } else {
                            BlocProvider.of<TransferCubit>(
                              context,
                            ).transferMoney(
                              receiverEmail: receiverEmailController.text,
                              amount: int.parse(
                                amountToTransferController.text,
                              ),
                              usebalance: false,
                              cardId: selectedMethod,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
