import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/credit_card_widget.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/features/acc&cards/data/models/response/get_cards_response/datum.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_cubit.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_states.dart';
import 'package:ibank/features/acc&cards/presentation/screens/add_card_screen.dart';
import 'package:ibank/features/acc&cards/presentation/widgets/accounts_tab.dart';
import 'package:ibank/features/acc&cards/presentation/widgets/cards_tab.dart';
import 'package:ibank/features/main/presentation/screens/main_screen.dart';

class AccountcardScreen extends StatefulWidget {
  const AccountcardScreen({super.key});
  @override
  State<AccountcardScreen> createState() => _AccountcardScreenState();
}

class _AccountcardScreenState extends State<AccountcardScreen> {
  bool isAccountSelected = true;
  List<Datum> cards = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccCardCubit>(
      create: (context) => AccCardCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Accounts and Cards', style: getTitle2TextStyle()),
        ),
        body: BlocConsumer<AccCardCubit, AccCardStates>(
          listener: (context, state) {
            if (state is AccCardLoadingState) {
              Dialogs.showLoadingDialog(context);
            } else if (state is GetCardsErrorState) {
              context.pop();
              Dialogs.showErrorDialog(context, state.error);
            } else if (state is GetCardsSuccessState) {
              cards = state.cards;
              context.pop();
            } else if (state is DeleteCardSuccessState) {
              context.pop();
              Dialogs.showSuccessSnackbar(context, state.message);
            } else if (state is DeleteCardErrorState) {
              context.pop();
              Dialogs.showErrorDialog(context, state.error);
            } else if (state is SetDefaultCardSuccessState) {
              context.pop();
              Dialogs.showSuccessSnackbar(context, state.message);
              context.pushAndRemoveUntil(MainScreen());
            } else if (state is SetDefaultCardErrorState) {
              context.pop();
              Dialogs.showErrorDialog(context, state.error);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomButtonWidget(
                        height: 44.h,
                        width: 155.w,
                        text: 'Account',
                        bgcolor:
                            isAccountSelected
                                ? AppColours.primaryColor1
                                : AppColours.primaryColor4,
                        textColor:
                            isAccountSelected
                                ? AppColours.naturalColor6
                                : AppColours.naturalColor1,
                        onPressed: () {
                          setState(() {
                            isAccountSelected = true;
                          });
                        },
                      ),
                      Spacer(),
                      CustomButtonWidget(
                        height: 44.h,
                        width: 155.w,
                        text: 'Cards',
                        bgcolor:
                            isAccountSelected
                                ? AppColours.primaryColor4
                                : AppColours.primaryColor1,
                        textColor:
                            isAccountSelected
                                ? AppColours.naturalColor1
                                : AppColours.naturalColor6,
                        onPressed: () {
                          setState(() {
                            isAccountSelected = false;
                            context.read<AccCardCubit>().getCards();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  isAccountSelected
                      ? Expanded(child: AccountsTab())
                      : Expanded(
                        child: CardsTab(
                          cards: cards,
                          cubit: context.read<AccCardCubit>(),
                        ),
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
