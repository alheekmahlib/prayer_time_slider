part of '../prayer_time_slider.dart';

class HumiditySlider extends StatelessWidget {
  const HumiditySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraintes) {
      // var maxHeight = constraintes.maxHeight;
      // var oneUnit = maxHeight / 100;
      // var value = PrayerSliderController.instance.transitionalValue.value;
      return Row(
        children: [
          MeasurementNumbers(),
          SliderHandle(),
        ],
      );
    });
  }
}

class SliderHandle extends StatelessWidget {
  const SliderHandle({super.key});
  // final double oneUnit;

  // final sliderCltrl = PrayerSliderController.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerSliderController>(builder: (sliderCltrl) {
      return SizedBox(
        width: 100,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 15,
              right: 40,
              child: CustomPaint(
                  painter: LinesPainter(
                      sliderCltrl.state, sliderCltrl.centerY!.value)),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 25,
              child: HumidityCurevedLine(
                y: sliderCltrl.centerY!.value,
              ),
            ),
            Positioned(
              right: 0,
              top: sliderCltrl.centerY!.value,
              child: GestureDetector(
                onVerticalDragStart: sliderCltrl.handleDrag,
                onVerticalDragUpdate: sliderCltrl.handleDrag,
                onVerticalDragEnd: (_) => sliderCltrl.updateFinalHumidity(),
                child: const SliderBall(),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class LinesPainter extends CustomPainter {
  LinesPainter(this.config, this.centerY);
  final SliderState config;
  final double centerY;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final linesCount = (config.list.length - 1) * 5 + 1;

    final paddingTop =
        config.paddingTopInPercentage * height / 100 + kNumberFontSize / 2;
    final paddingBottom =
        config.paddingBottomInPercentage * height / 100 + kNumberFontSize / 2;

    final oneLineStep =
        (height - paddingTop - paddingBottom) / (linesCount - 1);
    var y = paddingTop;
    var path = Path();

    for (var i = 0; i < linesCount; i++) {
      var isLong = i % 5 == 0;
      var startX = isLong ? 22.0 : 29.0;
      var endX = width;
      var fix = 23; // don't know why do I need it. 😅
      var distanceTillCenter = (y - centerY - fix).abs();
      if (distanceTillCenter < 50) {
        var sin = distanceTillCenter / 50;
        var angle = math.asin(sin);
        var cos = math.cos(angle);
        var delta = 30 * cos * cos * 1.05;
        startX -= delta;
        endX -= delta;
      }
      path
        ..moveTo(startX, y)
        ..lineTo(endX, y);

      y += oneLineStep;
    }

    var paint = Paint()
      ..color = BrandColors.fiord
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
