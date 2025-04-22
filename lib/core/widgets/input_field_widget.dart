import 'package:flutter/material.dart';
import 'package:ibank/core/functions/validation.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget({
    super.key,
    required this.hint,
    this.keyboardType,
    this.controller,
    this.isPassword,
  });
  final String hint;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? isPassword;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool showpassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (widget.keyboardType == TextInputType.emailAddress) {
          return emailValid(value);
        } else if (widget.isPassword == true) {
          return passwordValid(value);
        } else {
          return null;
        }
      },
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword == true ? showpassword : false,
      decoration: InputDecoration(
        suffixIcon:
            widget.isPassword == true
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      showpassword = !showpassword;
                    });
                  },
                  icon: Icon(
                    showpassword == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColours.naturalColor4,
                  ),
                )
                : null,
        hintText: widget.hint,
        hintStyle: getCaption2TextStyle(color: AppColours.naturalColor4),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: AppColours.primaryColor1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: AppColours.naturalColor4,
          ),
        ),
      ),
    );
  }
}
