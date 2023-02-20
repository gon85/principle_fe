import 'package:logger/logger.dart';

var loggerStack = Logger(
  printer: PrettyPrinter(colors: false),
);

var logger = Logger(
  printer:
      PrettyPrinter(methodCount: 0, colors: false, noBoxingByDefault: true),
);
