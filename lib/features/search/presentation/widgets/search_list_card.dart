import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/box_shadow.dart';
import 'package:ibank/core/utils/text_style.dart';

class SearchListCard extends StatelessWidget {
  SearchListCard(this.index, {super.key});
  final int index;
  final List<String> titles = [
    'Branch',
    'Interest rate',
    'Exchange rate',
    'Exchange',
  ];
  final List<String> subTitles = [
    'Search for branch',
    'Search for interest rate',
    'Search for exchange rate',
    'Exchange amount of money',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColours.naturalColor6,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [getDefaultBoxShadow2()],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titles[index], style: getBody1TextStyle()),
              SizedBox(height: 10.h),
              Text(
                subTitles[index],
                style: getCaption2TextStyle(color: AppColours.naturalColor3),
              ),
            ],
          ),
          const Spacer(),
          Image.asset('assets/images/search$index.png'),
        ],
      ),
    );
  }
}
