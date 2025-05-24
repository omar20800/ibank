import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/model/card_model.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/credit_card_widget.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/features/acc&cards/presentation/screens/add_card_screen.dart';
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
                            return Dismissible(
                              key: UniqueKey(),
                              confirmDismiss: (direction) {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Confirm Delete'),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      content: Text(
                                        'Are you sure you want to delete this card?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              secondaryBackground: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.w),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20.w),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              onDismissed: (direction) {
                                // Handle card dismissal
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Card dismissed')),
                                );
                              },
                              child: CreditCardWidget(
                                card: CardModel(
                                  cardnumber: '5454545454545454',
                                  cardholdername: 'Pedri Gonzales',
                                  expirationdate: '12/25',
                                ),
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
                        onPressed: () async {
                          await context.pushTo(AddCardScreen());
                          setState(() {});
                        },
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
