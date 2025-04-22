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
