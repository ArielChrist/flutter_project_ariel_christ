import 'package:flutter/material.dart';
import 'dart:math';

class ProgressGauge extends StatelessWidget {
  final double progress;
  final bool isCompleted;
  final VoidCallback? onRestart;

  const ProgressGauge({
    Key? key,
    required this.progress,
    required this.isCompleted,
    this.onRestart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CustomPaint(
            painter: GaugePainter(
              progress: progress,
              backgroundColor: Theme.of(context).dividerColor,
              progressColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        if (isCompleted)
          ElevatedButton(
            onPressed: onRestart,
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
            ),
            child: Icon(Icons.refresh, size: 30),
          )
        else
          Text(
            '${(progress * 100).toInt()}%',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}

class GaugePainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  GaugePainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Arrière-plan du cercle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progrès
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}