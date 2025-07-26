import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PictureWidget extends StatelessWidget {
  const PictureWidget({super.key, this.width, this.height, this.imagepath, this.imageURL});
  final double? width;
  final double? height;
  final String? imagepath;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: imageURL != null ? Image.network(
        imageURL!,
        width: width ?? 60.w,
        height: height ?? 60.h,
        fit: BoxFit.cover,
      )
      : Image.asset(
        imagepath ?? 'assets/images/pedri.jpg',
        width: width ?? 60.w,
        height: height ?? 60.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
