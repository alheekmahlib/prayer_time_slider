part of '../prayer_time_slider.dart';

class SliderBall extends StatelessWidget {
  const SliderBall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: BrandColors.sugarCane,
      ),
      height: kBallSize,
      width: kBallSize,
      alignment: Alignment.center,
      child: const Icon(
        FunIcons.verticalArrows,
        color: BrandColors.fiord,
        size: 20,
      ),
    );
  }
}
