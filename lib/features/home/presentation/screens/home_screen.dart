import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/picture_widget.dart';
import 'package:ibank/core/widgets/credit_card_widget.dart';
import 'package:ibank/features/acc&cards/presentation/cubit/acc_card_cubit.dart';
import 'package:ibank/features/acc&cards/presentation/screens/accountcard_screen.dart';
import 'package:ibank/features/home/presentation/widgets/home_tile_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UserModel? user = AppLocalStorage.getUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor1,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  children: [
                    PictureWidget(imageURL: user?.imageUrl),
                    SizedBox(width: 20.w),
                    Text(
                      'Hi, ${user?.name}',
                      style: getBody1TextStyle(color: AppColours.naturalColor6),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications),
                      color: AppColours.naturalColor6,
                      iconSize: 30.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    top: 10.h,
                    bottom: 20.h,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    color: AppColours.naturalColor6,
                  ),
                  child: Column(
                    children: [
                      CreditCardWidget(),
                      Expanded(
                        child: Row(
                          spacing: 15.w,
                          children: [
                            HomeTileWidget(
                              iconPath: 'assets/icons/wallet_icon.svg',
                              title: 'Account and Cards',
                              destination: AccountcardScreen(),
                            ),
                            HomeTileWidget(
                              title: 'Transfer',
                              iconPath: 'assets/icons/transfer.svg',
                              destination: AccountcardScreen(),
                            ),
                            HomeTileWidget(
                              title: 'Withdraw',
                              iconPath: 'assets/icons/credit-card.svg',
                              destination: AccountcardScreen(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Expanded(
                        child: Row(
                          spacing: 15.w,
                          children: [
                            HomeTileWidget(
                              iconPath: 'assets/icons/mobile-banking.svg',
                              title: 'Mobile prepaid',
                              destination: AccountcardScreen(),
                            ),
                            HomeTileWidget(
                              title: 'Pay the bill',
                              iconPath: 'assets/icons/receipt-list.svg',
                              destination: AccountcardScreen(),
                            ),
                            HomeTileWidget(
                              title: 'Save online',
                              iconPath: 'assets/icons/pig.svg',
                              destination: AccountcardScreen(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Expanded(
                        child: Row(
                          spacing: 15.w,
                          children: [
                            HomeTileWidget(
                              iconPath: 'assets/icons/credit-card 2.svg',
                              title: 'Credit card',
                              destination: AccountcardScreen(),
                            ),
                            HomeTileWidget(
                              title: 'Transaction report',
                              iconPath: 'assets/icons/file-paragraph.svg',
                              destination: AccountcardScreen(),
                            ),
                            HomeTileWidget(
                              title: 'Beneficiary',
                              iconPath: 'assets/icons/contacts.svg',
                              destination: AccountcardScreen(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
