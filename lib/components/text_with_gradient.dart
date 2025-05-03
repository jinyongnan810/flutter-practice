import 'package:flutter/material.dart';

class TextWithGradient extends StatelessWidget {
  const TextWithGradient({super.key, required this.text, this.fontSize = 40});
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Colors.black,
          Colors.pink,
        ],
        stops: const [0.0, 1.0],
      ).createShader(bounds),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
