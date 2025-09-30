import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.methods,
    this.onChanged,
    required this.hint,
    this.customValidator, required this.enabled,
  });
  final bool enabled;
  final List<DropdownMenuItem<String>> methods;
  final Function(String?)? customValidator;
  final String hint;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: (value) {
        if (customValidator != null) {
          return customValidator!(value);
        } else {
          return null;
        }
      },
      hint: Text(
        hint,
        style: getCaption2TextStyle(color: AppColours.naturalColor4),
      ),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColours.naturalColor3),
        ),
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
          borderSide: BorderSide(color: AppColours.primaryColor1),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      ),
      items: methods,
      onChanged: enabled
          ? (value) {
              if (onChanged != null && value != null) {
                onChanged!(value);
              }
            }
          : null,
    );
  }
}
