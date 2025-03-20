import 'package:flutter/material.dart';
import 'package:humidity_slider/humidity_slider/screen/scaffold.dart';
import 'package:prayer_time_slider/prayer_time_slider.dart';

class HumidityScreen extends StatelessWidget {
  const HumidityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HumiditySliderScaffold(
      activeIndex: 1,
      body: HumiditySliderPage(),
    );
  }
}

class HumiditySliderPage extends StatelessWidget {
  const HumiditySliderPage({super.key});

  final bool kShowBack = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: kShowBack
            ? const DecorationImage(
                image: AssetImage("assets/design.png"),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          SizedBox(
            width: 180,
            child: HumiditySlider(),
          ),
        ],
      ),
    );
  }
}
