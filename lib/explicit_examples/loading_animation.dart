import 'package:flutter/material.dart';

class RadialProgressAnimation extends StatefulWidget {
  final double progress;
  final Color color;

  const RadialProgressAnimation({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  State<RadialProgressAnimation> createState() =>
      _RadialProgressAnimationState();
}

class _RadialProgressAnimationState extends State<RadialProgressAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    animation = Tween<double>(begin: 0, end: widget.progress).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: animation.value,
                      strokeWidth: 20,
                      backgroundColor: Colors.grey.shade100,
                      color: widget.color,
                    ),
                  ),
                  Text(
                    '${(animation.value * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isCompleted || controller.isAnimating
              ? controller.status == AnimationStatus.reverse
                  ? controller.forward()
                  : controller.reverse()
              : controller.forward();
        },
        child: const Icon(Icons.start),
      ),
    );
  }
}
