import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

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
          child: LiquidCircularProgressIndicator(
            value: progress,
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            backgroundColor: Colors.white,
            borderColor: Theme.of(context).primaryColor.withOpacity(0.2),
            borderWidth: 4.0,
            direction: Axis.vertical,
            center: Text(
              isCompleted ? '✔' : '${(progress * 100).toInt()}%',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        if (isCompleted)
          Positioned(
            child: ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(18),
              ),
              child: Icon(Icons.refresh, size: 28),
            ),
          ),
      ],
    );
  }
}