part of '../prayer_time_slider.dart';

class PrayerSliderController extends GetxController {
  static PrayerSliderController get instance =>
      GetInstance().putOrFind(() => PrayerSliderController());
  PrayerSliderController() {
    _transitionalValue = defaultValue.toDouble();
    _finalValue = defaultValue.value;
  }

  double dy = 400;
  double diameter = kBallSize;
  SliderState state = SliderState();

  RxDouble min = 0.0.obs; // Initialize with default value
  RxDouble max = 100.0.obs; // Initialize with default value
  RxDouble stepHeight = 1.0.obs; // Initialize with default value
  late void Function(double) updateTrasitionalHumidity;
  late void Function() updateFinalHumidity;

  RxDouble? centerY = 0.0.obs; // Initialize centerY with a default value

  void handleDrag(details) {
    double newDy =
        (details.globalPosition.dy - diameter).clamp(min.value, max.value);

    if (dy != newDy) {
      updateTrasitionalHumidity(calcualteHumidity(newDy));
      dy = newDy;
      centerY!.value = dy - diameter / 2; // Update centerY whenever dy changes
    }
    update();
  }

  late double Function(double) calcualteHumidity;

  @override
  void onInit() {
    super.onInit();
    updateTrasitionalHumidity = updateTrasitionalValue;
    updateFinalHumidity = updateFinalValue;
    centerY!.value =
        dy - diameter / 2; // Ensure centerY is initialized correctly
    setState(1200 / 100);
    updateActiveIndex(); // Initialize activeIndex
  }

  void setState(double oneUnit) {
    var fontSizeShift = kNumberFontSize / 2;

    var paddingTop = oneUnit * state.paddingTopInPercentage + fontSizeShift;
    var paddingBottom =
        oneUnit * state.paddingBottomInPercentage + fontSizeShift;
    var height = oneUnit * 100;
    var body = height - paddingTop - paddingBottom;
    var stepsCount = state.list.length;
    stepHeight.value = body / (stepsCount - 1);
    var disacitvatedTopPart =
        stepHeight.value * (stepsCount - state.lastActiveIndex - 1);
    var disacitvatedBottomPart = stepHeight.value * (state.firstActiveIndex);

    calcualteHumidity = (newDy) {
      var procantage = 1 - (newDy - min.value) / (stepHeight.value * 5);

      var activeCapacity = state.list[state.lastActiveIndex] -
          state.list[state.firstActiveIndex];
      return procantage * activeCapacity + state.list[state.firstActiveIndex];
    };

    min.value = disacitvatedTopPart + paddingTop;
    max.value = height - disacitvatedBottomPart - paddingBottom;
  }

  RxInt defaultValue = 37.obs;

  double _transitionalValue = 0;
  RxDouble get transitionalValue => _transitionalValue.obs;

  int _finalValue = 5;
  RxInt get finalValue => _finalValue.obs;

  void updateTrasitionalValue(double newValue) {
    _transitionalValue = newValue;
    update();
  }

  void updateFinalValue() {
    _finalValue = _transitionalValue.round();
    update();
  }

  RxInt activeIndex = 0.obs;

  void updateActiveIndex() {
    var value = transitionalValue.value;
    var sortedList = [...state.list.reversed]
      ..sort((a, b) => (a - value).abs().compareTo((b - value).abs()));
    activeIndex.value =
        state.list.length - state.list.indexOf(sortedList.first) - 1;
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    super.update(ids, condition); // Call the original update method
    updateActiveIndex(); // Update activeIndex whenever the controller updates
  }
}
