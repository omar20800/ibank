import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/box_shadow.dart';
import 'package:ibank/core/utils/text_style.dart';

class HomeTileWidget extends StatelessWidget {
  const HomeTileWidget({
    super.key,
    required this.title,
    required this.iconPath,
    this.destination, this.onTap,
  });
  final String title;
  final String iconPath;
  final Widget? destination;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else if (destination != null) {
            context.pushTo(destination!);
          } else {
            
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColours.naturalColor6,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [getDefaultBoxShadow()],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(iconPath, width: 28.w, height: 28.h),
              SizedBox(height: 10.h),
              Text(
                textAlign: TextAlign.center,
                title,
                style: getCaption2TextStyle(color: AppColours.naturalColor3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
