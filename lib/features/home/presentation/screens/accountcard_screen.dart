import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/model/card_mode.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/box_shadow.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/credit_card_widget.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/core/widgets/picture_widget.dart';
import 'package:ibank/features/home/presentation/widgets/accounts_tab.dart';

class AccountcardScreen extends StatefulWidget {
  const AccountcardScreen({super.key});

  @override
  State<AccountcardScreen> createState() => _AccountcardScreenState();
}

class _AccountcardScreenState extends State<AccountcardScreen> {
  bool isAccountSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts and Cards', style: getTitle2TextStyle()),
      ),
      body: Padding(
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
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            isAccountSelected
                ? Expanded(child: AccountsTab())
                : Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return CreditCardWidget(
                              card: CardModel(
                                cardnumber: '5454545454545454',
                                cardholdername: 'Pedri Gonzales',
                                expirationdate: '12/25',
                              ),
                            );
                          },
                          separatorBuilder:
                              (context, index) => SizedBox(height: 5.h),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomButtonWidget(
                        height: 44.h,
                        text: 'Add new card',
                        bgcolor: AppColours.primaryColor1,
                        textColor: AppColours.naturalColor6,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
