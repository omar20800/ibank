import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PictureWidget extends StatelessWidget {
  const PictureWidget({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        'assets/images/pedri.jpg',
        width: width ?? 60.w,
        height: height ?? 60.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
