import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';

TextStyle getTitle1TextStyle({
  String? family,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: family ?? 'Poppins',
    fontSize: fontSize ?? 24.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? AppColours.textColor,
  );
}

TextStyle getTitle2TextStyle({
  String? family,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: family ?? 'Poppins',
    fontSize: fontSize ?? 20.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? AppColours.textColor,
  );
}

TextStyle getTitle3TextStyle({
  String? family,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: family ?? 'Poppins',
    fontSize: fontSize ?? 16.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? AppColours.textColor,
  );
}

TextStyle getBody1TextStyle({
  String? family,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: family ?? 'Poppins',
    fontSize: fontSize ?? 16.sp,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color ?? AppColours.textColor,
  );
}

TextStyle getBody2TextStyle({
  String? family,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: family ?? 'Poppins',
    fontSize: fontSize ?? 16.sp,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? AppColours.textColor,
  );
}

TextStyle getBody3TextStyle({
  String? family,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: family ?? 'Poppins',
    fontSize: fontSize ?? 14.sp,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color ?? AppColours.textColor,
  );
}

TextStyle getCaption1TextStyle({
  String? family,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: family ?? 'Poppins',
    fontSize: fontSize ?? 12.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? AppColours.textColor,
  );
}

TextStyle getCaption2TextStyle({
  String? family,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: family ?? 'Poppins',
    fontSize: fontSize ?? 14.sp,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color ?? AppColours.textColor,
  );
}
