import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate {
  static Future<String?> SELECTDATE(BuildContext context) async {
    String? selectedDate;
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));
    if (date != null) {
      selectedDate = "${date.day}/${date.month}/${date.year}";
    } else {
      selectedDate = null;
    }
    return selectedDate;
  }
}
