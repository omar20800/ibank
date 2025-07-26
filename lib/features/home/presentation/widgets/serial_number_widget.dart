import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/service/auth_service.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';

class SerialNumberWidget extends StatefulWidget {
  const SerialNumberWidget({super.key, required this.serialNumber});
  final String serialNumber;

  @override
  State<SerialNumberWidget> createState() => _SerialNumberWidgetState();
}

class _SerialNumberWidgetState extends State<SerialNumberWidget> {
  bool isAuthenticated = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AuthService().authenticateWithBiometrics('Please authenticate').then((value) {
          if (value == true) {
            setState(() {
              isAuthenticated = true;
            });
          } else {
            setState(() {
              isAuthenticated = false;
            });
          }
        });
      },
      child: Row(
        children: [
          Text(
            getSerialNumber(widget.serialNumber, 1),
            style: getBody1TextStyle(color: AppColours.naturalColor6),
          ),
          SizedBox(width: 10.w),
          Text(
            !isAuthenticated ? '****' : getSerialNumber(widget.serialNumber, 2),
            style: getBody1TextStyle(color: AppColours.naturalColor6),
          ),
          SizedBox(width: 10.w),
          Text(
            !isAuthenticated ? '****' : getSerialNumber(widget.serialNumber, 3),
            style: getBody1TextStyle(color: AppColours.naturalColor6),
          ),
          SizedBox(width: 10.w),
          Text(
            getSerialNumber(widget.serialNumber, 4),
            style: getBody1TextStyle(color: AppColours.naturalColor6),
          ),
        ],
      ),
    );
  }

  String getSerialNumber(String serialNumber, int index) {
    switch (index) {
      case 1:
        return serialNumber.substring(0, 4);
      case 2:
        return serialNumber.substring(4, 8);
      case 3:
        return serialNumber.substring(8, 12);
      case 4:
        return serialNumber.substring(12, 16);
      default:
        return serialNumber;
    }
  }
}
