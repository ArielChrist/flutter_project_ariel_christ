import 'package:flutter/material.dart';

class ThemedBackground extends StatelessWidget {
  final Widget child;

  const ThemedBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/background_image.webp', // Remplace par ton chemin
          fit: BoxFit.cover,
          color: isDark ? Colors.black.withOpacity(0.6) : null,
          colorBlendMode: isDark ? BlendMode.darken : null,
        ),
        child,
      ],
    );
  }
}
