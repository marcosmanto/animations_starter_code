import 'package:flutter/material.dart';

class PulsatingCircleAnimation extends StatefulWidget {
  const PulsatingCircleAnimation({super.key});

  @override
  State<PulsatingCircleAnimation> createState() =>
      _PulsatingCircleAnimationState();
}

class _PulsatingCircleAnimationState extends State<PulsatingCircleAnimation> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pulsating Circle $i'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                i = ++i;
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0,
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
      body: Center(
        child: TweenAnimationBuilder(
            key: ValueKey(i),
            curve: Curves.easeOutExpo,
            tween: Tween<double>(begin: 0, end: 200),
            duration: const Duration(milliseconds: 1200),
            builder: (context, object, widget) {
              return Container(
                width: object,
                height: object,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: object,
                      spreadRadius: object / 2,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
