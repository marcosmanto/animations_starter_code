import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedColorPalette extends StatefulWidget {
  const AnimatedColorPalette({super.key});

  @override
  State<AnimatedColorPalette> createState() => _AnimatedColorPaletteState();
}

class _AnimatedColorPaletteState extends State<AnimatedColorPalette> {
  List<Color> currentPalette = generateRandomPalette();

  static List<Color> generateRandomPalette() {
    final random = Random();
    return List.generate(
      5,
      (_) => Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      ),
    );
  }

  void regeneratePalette() {
    setState(() {
      currentPalette = generateRandomPalette();
    });
  }

  double getRandomDoubleBetween(double min, double max) {
    return min + Random().nextDouble() * (max - min + double.minPositive);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Palette Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Color color in currentPalette)
              Expanded(
                child: AnimatedContainer(
                  curve: Curves.easeOutCirc,
                  duration: const Duration(milliseconds: 300),
                  width: size.width * getRandomDoubleBetween(.5, .75),
                  //height: 100,
                  color: color,
                  margin: const EdgeInsets.all(8),
                ),
              ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 10),
              height: 80,
              child: ElevatedButton(
                onPressed: regeneratePalette,
                child: const Text('Generate New Palette'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
