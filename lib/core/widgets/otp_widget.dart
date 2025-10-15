import 'package:flutter/material.dart';
import 'package:ibank/core/functions/validation.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    super.key,
    required this.otpController,
  });

  final TextEditingController? otpController;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: otpController,
      length: 6,
      errorPinTheme: PinTheme(
        width: 70,
        height: 60,
        textStyle: TextStyle(
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          color: AppColours.naturalColor1,
        ),
        decoration: BoxDecoration(
          color: AppColours.naturalColor6,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColours.semanticColor1,
            width: 1.2,
          ),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 70,
        height: 60,
        textStyle: TextStyle(
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          color: AppColours.naturalColor1,
        ),
        decoration: BoxDecoration(
          color: AppColours.naturalColor6,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColours.primaryColor1,
            width: 1.2,
          ),
        ),
      ),
      validator: (value) => otpValid(value),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      defaultPinTheme: PinTheme(
        width: 70,
        height: 60,
        textStyle: TextStyle(
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          color: AppColours.naturalColor1,
        ),
        decoration: BoxDecoration(
          color: AppColours.naturalColor6,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColours.naturalColor4,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
