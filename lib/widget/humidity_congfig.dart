part of '../prayer_time_slider.dart';

class SliderState {
  int firstActiveIndex = 0;
  int lastActiveIndex = 9;

  final paddingTopInPercentage = 13.3;
  final paddingBottomInPercentage = 11.2;

  final List<int> list = const [0, 10, 25, 30, 35, 40, 45, 50, 75, 100];
}

double kNumberFontSize = 18;
