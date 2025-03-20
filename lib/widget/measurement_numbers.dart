part of '../prayer_time_slider.dart';

class MeasurementNumbers extends StatelessWidget {
  const MeasurementNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var sliderCtrl = PrayerSliderController.instance;
      var list = sliderCtrl.state.list;
      var firstIndex = sliderCtrl.state.firstActiveIndex;
      var lastIndex = sliderCtrl.state.lastActiveIndex;
      var paddingTop = sliderCtrl.state.paddingTopInPercentage * (1200 / 100);
      var paddingBottom =
          sliderCtrl.state.paddingBottomInPercentage * (1200 / 100);
      var value = sliderCtrl.transitionalValue.value;

      return Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: paddingTop,
              child: Text(value.toStringAsFixed(3)),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildNumbers(list, firstIndex, lastIndex, value,
                    sliderCtrl.activeIndex.value),
              ),
            ),
            SizedBox(height: paddingBottom),
          ],
        ),
      );
    });
  }

  List<Widget> _buildNumbers(
      List list, int firstIndex, int lastIndex, double value, int activeIndex) {
    return list.reversed
        .toList()
        .asMap()
        .map((i, n) => MapEntry(
              i,
              Row(
                children: [
                  Icon(
                    Icons.brightness_1,
                    size: 6,
                    color: n <= list[firstIndex] || n >= list[lastIndex]
                        ? BrandColors.attention
                        : Colors.transparent,
                  ),
                  AnimatedText(
                    key: ValueKey(n),
                    notActiveNumber: n,
                    activeValue: value,
                    isActive: i == activeIndex,
                    oneUnit: 1200 / 100,
                  ),
                ],
              ),
            ))
        .values
        .toList();
  }
}

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
    required this.notActiveNumber,
    required this.activeValue,
    required this.isActive,
    required this.oneUnit,
  });

  final int notActiveNumber;
  final double activeValue;
  final double oneUnit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    String text;
    Offset offset;

    if (isActive) {
      text = ' ${activeValue.round()}%';
      var dy = (notActiveNumber - activeValue) * oneUnit;
      offset = Offset(0, dy);
    } else {
      text = ' $notActiveNumber%';
      offset = Offset.zero;
    }

    return Transform.scale(
      alignment: Alignment.centerLeft,
      scale: isActive ? 1.4 : 1.0, // Scale based on active state
      child: Transform.translate(
        offset: offset,
        child: Text(
          text,
          style: TextStyle(
            fontSize: kNumberFontSize,
            fontWeight: FontWeight.w900,
            height: 1,
            color: isActive ? BrandColors.cerulean : BrandColors.sugarCane,
          ),
        ),
      ),
    );
  }
}
