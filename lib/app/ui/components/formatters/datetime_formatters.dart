import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DateFormatter extends TextInputFormatter {
  final String sample;
  final String separator;

  DateFormatter({required this.sample, required this.separator});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    if (newValue.text.length <= oldValue.text.length) return newValue;
    if (newValue.text.length > sample.length) return oldValue;
    String date = newValue.text.removeAllWhitespace.replaceAll(separator, '');

    String text = '';
    int len = date.length;
    if (len <= 4) {
      text = '${date.substring(0)}${len == 4 ? separator : ''}';
    } else if (len <= 6) {
      text =
          '${date.substring(0, 4)}$separator${date.substring(4, len)}${len == 6 ? separator : ''}';
    } else if (len <= 8) {
      text =
          '${date.substring(0, 4)}$separator${date.substring(4, 6)}$separator${date.substring(6, len)}';
    } else {
      text =
          '${date.substring(0, 4)}$separator${date.substring(4, 6)}$separator${date.substring(6, 8)}';
    }

    return TextEditingValue(
        text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}

class TimeFormatter extends TextInputFormatter {
  final String sample;
  final String separator;

  TimeFormatter({required this.sample, required this.separator});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    if (newValue.text.length <= oldValue.text.length) return newValue;
    if (newValue.text.length > sample.length) return oldValue;

    String time = newValue.text.removeAllWhitespace.replaceAll(separator, '');
    String text = '';
    int len = time.length;
    if (len <= 2) {
      text = '$time${len == 2 ? separator : ''}';
    } else if (len <= 4) {
      text =
          '${time.substring(0, 2)}$separator${time.substring(2, len)}${len == 4 ? separator : ''}';
    } else if (len <= 6) {
      text =
          '${time.substring(0, 2)}$separator${time.substring(2, 4)}$separator${time.substring(4, len)}';
    } else {
      text =
          '${time.substring(0, 2)}$separator${time.substring(2, 4)}$separator${time.substring(4, 6)}';
    }

    return TextEditingValue(
        text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}
