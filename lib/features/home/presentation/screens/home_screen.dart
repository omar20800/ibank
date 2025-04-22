import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/features/home/presentation/widgets/home_tile_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    ClipOval(
                      child: Image.asset(
                        'assets/images/pedri.jpg',
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      'Hi, Pedri Gonzalez',
                      style: getBody1TextStyle(color: AppColours.naturalColor6),
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications,
                      color: AppColours.naturalColor6,
                      size: 30.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
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
                      Image.asset(
                        'assets/images/visa.png',
                        width: double.infinity,
                        height: 220.h,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        spacing: 15.w,
                        children: [
                          HomeTileWidget(
                            iconPath: 'assets/icons/wallet_icon.svg',
                            title: 'Account and Cards',
                          ),
                          HomeTileWidget(
                            title: 'Transfer',
                            iconPath: 'assets/icons/transfer.svg',
                          ),
                          HomeTileWidget(
                            title: 'Withdraw',
                            iconPath: 'assets/icons/credit-card.svg',
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        spacing: 15.w,
                        children: [
                          HomeTileWidget(
                            iconPath: 'assets/icons/mobile-banking.svg',
                            title: 'Mobile prepaid',
                          ),
                          HomeTileWidget(
                            title: 'Pay the bill',
                            iconPath: 'assets/icons/receipt-list.svg',
                          ),
                          HomeTileWidget(
                            title: 'Save online',
                            iconPath: 'assets/icons/pig.svg',
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        spacing: 15.w,
                        children: [
                          HomeTileWidget(
                            iconPath: 'assets/icons/credit-card 2.svg',
                            title: 'Credit card',
                          ),
                          HomeTileWidget(
                            title: 'Transaction report',
                            iconPath: 'assets/icons/file-paragraph.svg',
                          ),
                          HomeTileWidget(
                            title: 'Beneficiary',
                            iconPath: 'assets/icons/contacts.svg',
                          ),
                        ],
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
