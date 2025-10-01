import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibank/core/functions/validation.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/input_formatters.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/features/auth/presentation/auth_constants.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget({
    super.key,
    required this.hint,
    this.keyboardType,
    this.controller,
    this.isPassword,
    this.dateyearpicker = false,
    this.validator,
    this.customValidator,
  });
  final String hint;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? isPassword;
  final bool dateyearpicker;
  final Function()? customValidator;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool showpassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.hint == 'Enter CVV' ? 3 : null,
      inputFormatters:
          widget.hint == 'Enter Card Number'
              ? [
                LengthLimitingTextInputFormatter(19),
                CardNumberInputFormatter(),
              ]
              : null,
      validator: (value) {
        if (widget.validator != null) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          if (widget.keyboardType == TextInputType.emailAddress) {
            return emailValid(value);
          } else if (widget.hint == AuthConstants.passwordhint) {
            return passwordValid(value);
          } else if (widget.hint == 'Enter CVV') {
            return cvvValid(value);
          } else {
            return null;
          }
        } else if (widget.customValidator != null) {
          return widget.customValidator!();
        } else {
          return null;
        }
      },
      onTap:
          widget.dateyearpicker
              ? () async {
                int selectedMonth = DateTime.now().month;
                int selectedYear = DateTime.now().year;
                await showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text("Select Month and Year"),
                      content: StatefulBuilder(
                        builder: (
                          BuildContext context,
                          StateSetter setState,
                        ) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              DropdownButton<int>(
                                value: selectedMonth,
                                items: List.generate(12, (index) {
                                  return DropdownMenuItem(
                                    value: index + 1,
                                    child: Text('${index + 1}'),
                                  );
                                }),
                                onChanged: (int? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedMonth = newValue;
                                    });
                                  }
                                },
                              ),
                              DropdownButton<int>(
                                value: selectedYear,
                                items: List.generate(11, (index) {
                                  return DropdownMenuItem(
                                    value: DateTime.now().year + index,
                                    child: Text(
                                      '${DateTime.now().year + index}',
                                    ),
                                  );
                                }),
                                onChanged: (int? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedYear = newValue;
                                    });
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(
                              dialogContext,
                            ).pop(DateTime(selectedYear, selectedMonth, 1));
                          },
                        ),
                      ],
                    );
                  },
                ).then((value) {
                  if (value != null && value is DateTime) {
                    setState(() {
                      widget.controller?.text =
                          '${value.month}/${value.year.toString().substring(2)}';
                    });
                  }
                });
              }
              : null,
      readOnly: widget.dateyearpicker,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword == true ? showpassword : false,
      decoration: InputDecoration(
        counterText: '',
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
