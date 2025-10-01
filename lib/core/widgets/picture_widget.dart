import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';

class PictureWidget extends StatelessWidget {
  const PictureWidget({
    super.key,
    this.width,
    this.height,
    this.imagepath,
    this.imageURL,
    this.onTap,
    this.borderColor,
    this.borderWidth,
  });
  final double? width;
  final double? height;
  final Function()? onTap;
  final Color? borderColor;
  final double? borderWidth;
  final String? imagepath;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: width ?? 60.w,
        height: height ?? 60.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? AppColours.primaryColor1,
            width: borderWidth ?? 5.w,
          ),
        ),
        child: ClipOval(
          child:
              imageURL != null
                  ? CachedNetworkImage(
                    imageUrl: imageURL!,
                    width: width ?? 60.w,
                    height: height ?? 60.h,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => CircularProgressIndicator(
                          color: AppColours.primaryColor2,
                        ),
                    errorWidget:
                        (context, url, error) => Image.asset(
                          'assets/images/placeholder.png',
                          width: width ?? 60.w,
                          height: height ?? 60.h,
                          fit: BoxFit.cover,
                        ),
                  )
                  : Image.asset(
                    imagepath ?? 'assets/images/placeholder.png',
                    width: width ?? 60.w,
                    height: height ?? 60.h,
                    fit: BoxFit.cover,
                  ),
        ),
      ),
    );
  }
}
