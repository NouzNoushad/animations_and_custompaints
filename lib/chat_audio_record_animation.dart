import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChatAudioRecordAnimation extends StatefulWidget {
  const ChatAudioRecordAnimation({super.key});

  @override
  State<ChatAudioRecordAnimation> createState() =>
      _ChatAudioRecordAnimationState();
}

class _ChatAudioRecordAnimationState extends State<ChatAudioRecordAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 244, 235, 1),
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Column(children: [
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(width: 1.5, color: Colors.grey.shade300)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Align(
                      alignment: Alignment.centerLeft, child: Text('Message')),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const MicButton(),
            ],
          ),
        )
      ]),
    );
  }
}

class MicButton extends StatefulWidget {
  const MicButton({super.key});

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> timerAnimation;
  late Animation<double> lockerAnimation;
  double timerWidth = 0;
  String timeDuration = "00:00";
  Timer? timer;
  DateTime? startTime;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    scaleAnimation = Tween<double>(begin: 1, end: 2).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticInOut)));
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    timerWidth = MediaQuery.of(context).size.width - 2 * 4;
    timerAnimation = Tween<double>(begin: timerWidth + 8, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.2, 1, curve: Curves.easeIn)));
    lockerAnimation = Tween<double>(begin: timerWidth + 8, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.2, 1, curve: Curves.easeIn)));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        lockSlider(),
        cancelSlider(),
        GestureDetector(
          onLongPressDown: (_) {
            print('long press');
            controller.forward();
          },
          onLongPressEnd: (detail) {
            var isCancelled = detail.localPosition.dx <
                -(MediaQuery.of(context).size.width * 0.2);
            if (isCancelled) {
              timer?.cancel();
              startTime = null;
              timeDuration = "00:00";
              Timer(const Duration(milliseconds: 1500), () {
                controller.reverse();
              });
            } else {
              controller.reverse();
              timer?.cancel();
              startTime = null;
              timeDuration = "00:00";
              Timer(const Duration(milliseconds: 600), () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message Recorded')));
              });
            }
          },
          onLongPressCancel: () {
            controller.reverse();
          },
          onLongPress: () {
            startTime = DateTime.now();
            timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              final minute = DateTime.now().difference(startTime!).inMinutes;
              final second =
                  DateTime.now().difference(startTime!).inSeconds % 60;
              String min = minute.toString().padLeft(2, '0');
              String sec = second.toString().padLeft(2, '0');
              setState(() {
                timeDuration = "$min:$sec";
              });
            });
          },
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 25,
              child: Icon(
                Icons.mic,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget lockSlider() => Positioned(
      bottom: -lockerAnimation.value,
      child: Container(
        height: 200,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            const Icon(Icons.lock),
            const SizedBox(
              height: 10,
            ),
            const Column(
              children: [
                Icon(Icons.keyboard_arrow_up),
                Icon(Icons.keyboard_arrow_up),
                Icon(Icons.keyboard_arrow_up),
              ],
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 1200.ms, color: Colors.white, angle: 30),
          ],
        ),
      ));

  Widget cancelSlider() => Positioned(
      bottom: 0,
      right: -timerAnimation.value,
      child: Container(
        height: 50,
        width: timerWidth,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.mic,
                color: Colors.pink,
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .fade(duration: 1.seconds),
              Text(timeDuration),
              const SizedBox(
                width: 20,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.keyboard_arrow_left),
                  Text('Slide to cancel'),
                ],
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1200.ms, color: Colors.white, angle: 10),
              const SizedBox(
                width: 20,
              ),
            ]),
      ));
}

// class FlowShader extends StatefulWidget {
//   const FlowShader(
//       {super.key,
//       required this.child,
//       this.direction = Axis.horizontal,
//       this.duration = const Duration(seconds: 2),
//       this.flowColors = const [Colors.white, Colors.black]});
//   final Widget child;
//   final Axis direction;
//   final Duration duration;
//   final List<Color> flowColors;

//   @override
//   State<FlowShader> createState() => _FlowShaderState();
// }

// class _FlowShaderState extends State<FlowShader>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation firstAnimation;
//   late Animation secondAnimation;
//   late Animation thirdAnimation;

//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(vsync: this, duration: widget.duration);
//     final TweenSequenceItem item1 = TweenSequenceItem(
//         tween: ColorTween(
//             begin: widget.flowColors.last, end: widget.flowColors.first),
//         weight: 1);
//     final TweenSequenceItem item2 = TweenSequenceItem(
//         tween: ColorTween(
//             begin: widget.flowColors.first, end: widget.flowColors.last),
//         weight: 1);
//     firstAnimation = TweenSequence([item1, item2]).animate(CurvedAnimation(
//         parent: controller,
//         curve: const Interval(
//           0.0,
//           0.45,
//           curve: Curves.linear,
//         )));
//     secondAnimation = TweenSequence([item1, item2]).animate(CurvedAnimation(
//         parent: controller,
//         curve: const Interval(
//           0.15,
//           0.75,
//           curve: Curves.linear,
//         )));
//     thirdAnimation = TweenSequence([item1, item2]).animate(CurvedAnimation(
//         parent: controller,
//         curve: const Interval(
//           0.45,
//           1,
//           curve: Curves.linear,
//         )));
//     controller.forward();
//     controller.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (rect) {
//         return LinearGradient(
//           colors: [
//             thirdAnimation.value,
//             secondAnimation.value,
//             firstAnimation.value,
//           ],
//           begin: widget.direction == Axis.horizontal
//               ? Alignment.centerLeft
//               : Alignment.topCenter,
//           end: widget.direction == Axis.horizontal
//               ? Alignment.centerRight
//               : Alignment.bottomCenter,
//         ).createShader(rect);
//       },
//       child: widget.child,
//     );
//   }
// }

