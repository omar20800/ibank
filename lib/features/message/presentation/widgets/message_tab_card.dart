import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/box_shadow.dart';
import 'package:ibank/core/utils/text_style.dart';

class MessageTabCard extends StatelessWidget {
  MessageTabCard(this.index, {super.key});

  final int index;
  final List<String> senders = [
    'Bank of America',
    'Account',
    'Alert',
    'Paypal',
    'Withdraw',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.h,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColours.naturalColor6,
        boxShadow: [getDefaultBoxShadow2()],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/messagetab$index.svg'),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(senders[index], style: getBody1TextStyle()),
                    const Spacer(),
                    Text(
                      'Today',
                      style: getCaption2TextStyle(
                        color: AppColours.naturalColor2,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Empty Message',
                  style: getCaption2TextStyle(color: AppColours.naturalColor3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
