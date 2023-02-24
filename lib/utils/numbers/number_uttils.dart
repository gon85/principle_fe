import 'package:intl/intl.dart';

class NumberUtils {
  NumberUtils._privateConstructor();
  static final NumberUtils _instance = NumberUtils._privateConstructor();

  // factory NumberUtils() {
  //   return _instance;
  // }
  static get to => _instance;

  String format(num val) {
    NumberFormat f = NumberFormat('###,###,###,###.##');
    return f.format(val);
  }
}
