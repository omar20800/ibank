String? passwordValid(String? value) {
  if (value == null || value.isEmpty) {
    return "This field is can't be empty";
  } else if (value.contains(RegExp(r'[a-zA-Z]'))) {
    return "Password must contain only numbers";
  } else if (value.length < 6) {
    return "Password must be at least 6 characters";
  } else {
    return null;
  }
}

String? emailValid(String? value) {
  if (value == null || value.isEmpty) {
    return "This field is can't be empty";
  } else if (!value.contains(
    RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ),
  )) {
    return "Invalid email format";
  } else {
    return null;
  }
}

String? usernameValid(String? value) {
  if (value == null || value.isEmpty) {
    return "This field is can't be empty";
  } else if (value.length < 3) {
    return "Username must be at least 3 characters";
  } else if (value.length > 20) {
    return "Username must be at most 20 characters";
  } else {
    return null;
  }
}

String? otpValid(String? value) {
  if (value == null || value.isEmpty) {
    return "This field is can't be empty";
  } else if (value.contains(RegExp(r'[a-zA-Z]'))) {
    return "OTP must contain only numbers";
  } else if (value.length != 6) {
    return "OTP must be 6 numbers";
  } else {
    return null;
  }
}
String? cvvValid(String? value){
  if (value == null || value.isEmpty) {
    return "This field is can't be empty";
  } else if (value.contains(RegExp(r'[a-zA-Z]'))) {
    return "CVV must contain only numbers";
  } else if (value.length != 3) {
    return "CVV must be 3 digits";
  } else {
    return null;
  }
}
String? creditCardNumberValid(String? value) {
  if (value == null || value.isEmpty) {
    return "Credit card number can't be empty";
  }

  // 🧹 إزالة المسافات والـ dashes من الرقم
  String cleanedValue = value.replaceAll(RegExp(r'\s|-'), '');

  // 🔢 تأكيد أن الرقم يحتوي على أرقام فقط
  if (!RegExp(r'^\d+$').hasMatch(cleanedValue)) {
    return "Credit card number must contain only digits";
  }

  // 📏 التأكد من نوع الكارت وطوله
  final int length = cleanedValue.length;
  bool isValidLength = false;
  String? cardType;

  if (RegExp(r'^4').hasMatch(cleanedValue)) {
    if (length == 13 || length == 16) {
      isValidLength = true;
      cardType = 'Visa';
    }
  } else if (RegExp(r'^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[0-2])').hasMatch(cleanedValue)) {
    if (length == 16) {
      isValidLength = true;
      cardType = 'MasterCard';
    }
  } else if (RegExp(r'^(34|37)').hasMatch(cleanedValue)) {
    if (length == 15) {
      isValidLength = true;
      cardType = 'American Express';
    }
  } else if (RegExp(r'^(6011|622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[0-1][0-9]|92[0-5]|64[4-9])|65)').hasMatch(cleanedValue)) {
    if (length == 16 || length == 19) {
      isValidLength = true;
      cardType = 'Discover';
    }
  } else {
    return "Invalid credit card number or unrecognized type";
  }

  if (!isValidLength || cardType == null) {
    return "Invalid credit card number or unrecognized type";
  }

  // ✅ تحقق Luhn (خوارزمية التحقق من الرقم)
  int sum = 0;
  bool isSecondDigit = false;

  for (int i = cleanedValue.length - 1; i >= 0; i--) {
    int digit = int.parse(cleanedValue[i]);

    if (isSecondDigit) {
      digit *= 2;
      if (digit > 9) {
        digit -= 9;
      }
    }

    sum += digit;
    isSecondDigit = !isSecondDigit;
  }

  if (sum % 10 != 0) {
    return "Invalid credit card number (Luhn check failed)";
  }

  return null;
}
