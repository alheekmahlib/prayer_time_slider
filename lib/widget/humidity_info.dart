// part of '../prayer_time_slider.dart';

// class HumidityInfo extends StatelessWidget {
//   const HumidityInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var value = context.watch<Humidity>().finalValue;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Spacer(flex: 2),
//         Container(
//           height: 500,
//           alignment: Alignment.topLeft,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const _Subtitle('Return temperature'),
//               const SizedBox(height: 10),
//               const Text(
//                 '20℃',
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 50),
//               const _Subtitle('Current humidity'),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   AnimatedLetter(
//                     letter: value.toString()[0],
//                   ),
//                   AnimatedLetter(
//                     letter: value.toString()[1],
//                   ),
//                   SizedBox(
//                     child: Text('%', style: currentHumidityStyle),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 40),
//               const _Subtitle('Absolute humidity'),
//               const SizedBox(height: 12),
//               const Text(
//                 '4gr/fg3',
//                 style: TextStyle(
//                   fontSize: 27,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 42),
//               Icon(
//                 FunIcons.warningSign,
//                 color: BrandColors.attention,
//               ),
//               const SizedBox(height: 10),
//               RichText(
//                 text: TextSpan(
//                   children: <InlineSpan>[
//                     WidgetSpan(
//                       alignment: PlaceholderAlignment.middle,
//                       child: Icon(
//                         Icons.brightness_1,
//                         size: 8,
//                         color: BrandColors.attention,
//                       ),
//                     ),
//                     const TextSpan(
//                       style: TextStyle(height: 1.3),
//                       text:
//                           ' — extreme humidity level. \n Use precaution for set-points \n outside of 20%-50%',
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         const Spacer(flex: 1),
//       ],
//     );
//   }
// }

// class AnimatedLetter extends StatefulWidget {
//   const AnimatedLetter({super.key, required this.letter});

//   final String letter;

//   @override
//   _AnimatedLetterState createState() => _AnimatedLetterState();
// }

// class _AnimatedLetterState extends State<AnimatedLetter>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   late String currentLetter;
//   late String prevLetter;

//   @override
//   void initState() {
//     controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     currentLetter = widget.letter;
//     prevLetter = widget.letter;
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(AnimatedLetter oldWidget) {
//     if (widget.letter != oldWidget.letter) {
//       setState(() {
//         prevLetter = oldWidget.letter;
//         currentLetter = widget.letter;
//         controller
//           ..reset()
//           ..forward();
//       });
//     }

//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//         animation: controller,
//         builder: (_, __) {
//           return SizedBox(
//             width: 48,
//             child: Stack(
//               children: [
//                 Transform.translate(
//                   offset: Offset(0, -controller.value * 50),
//                   child: Opacity(
//                     opacity: 1 - controller.value,
//                     child: Text(
//                       prevLetter,
//                       style: currentHumidityStyle,
//                     ),
//                   ),
//                 ),
//                 Transform.translate(
//                   offset: Offset(0, 50 - controller.value * 50),
//                   child: Opacity(
//                     opacity: controller.value,
//                     child: Text(
//                       currentLetter,
//                       style: currentHumidityStyle,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }

// class _Subtitle extends StatelessWidget {
//   const _Subtitle(this.text);

//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text.toUpperCase(),
//       style: Theme.of(context).textTheme.titleLarge,
//     );
//   }
// }
