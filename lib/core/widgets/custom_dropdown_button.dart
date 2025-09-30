import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.methods,
    this.onChanged, required this.hint,
  });

  final List<DropdownMenuItem<String>> methods;
  final String hint;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(hint, style: getCaption2TextStyle(color: AppColours.naturalColor4),),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColours.textColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColours.textColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColours.textColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      ),
      items: methods,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value!);
        }
      },
    );
  }
}
