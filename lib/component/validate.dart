String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}

String? phonevalidata(String? password) {
  if (password == null || password.isEmpty)
    return 'Phone is required.';
  else if (password.length > 12) {
    return "Phone number must be grater then 12 characters";
  }
}

String? validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Phone number is required.';
  }

  if (value.length < 11) {
    return 'Phone number should have more than 11 characters.';
  }

  final RegExp phoneRegex = RegExp(r'^[0-9]+$');
  if (!phoneRegex.hasMatch(value)) {
    return 'Invalid phone number format. Only numeric characters are allowed.';
  }

  return null;
}

String? validatePricreNumber(String value) {
  if (value.isEmpty) {
    return 'Phone number is required.';
  }

  final RegExp phoneRegex = RegExp(r'^[0-9]+$');
  if (!phoneRegex.hasMatch(value)) {
    return 'Invalid phone number format. Only numeric characters are allowed.';
  }

  return null; // Return null if the value passes all validations.
}

String? validateCnicNumber(String value) {
  if (value.isEmpty) {
    return 'Cnic number is required.';
  }

  if (value.length < 13) {
    return 'Cnic number should have more than 13 characters.';
  }

  final RegExp phoneRegex = RegExp(r'^[0-9]+$');
  if (!phoneRegex.hasMatch(value)) {
    return 'Invalid cnic number format. Only numeric characters are allowed.';
  }

  return null; // Return null if the value passes all validations.
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Password is required.';
  }

  if (value.length < 6) {
    return 'Password should have more than 6 characters.';
  }

  final RegExp letterRegex = RegExp(r'[a-zA-Z]');
  final RegExp digitRegex = RegExp(r'[0-9]');

  if (!letterRegex.hasMatch(value) || !digitRegex.hasMatch(value)) {
    return 'Password should contain both letters and numbers.';
  }

  if (int.tryParse(value) != null) {
    return 'Password cannot consist only of numbers.';
  }

  return null; // Return null if the value passes all validations.
}
