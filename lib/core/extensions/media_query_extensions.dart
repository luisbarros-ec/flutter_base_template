import 'package:flutter/widgets.dart';

extension MediaQueryValues on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  double get shortestSide => MediaQuery.sizeOf(this).shortestSide;

  double get longestSide => MediaQuery.sizeOf(this).longestSide;
}
