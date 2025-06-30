import 'package:get/get.dart';
import 'dart:async';

class HomeController extends GetxController {
  final _progress = 0.0.obs;
  final _currentMessageIndex = 0.obs;
  final _isCompleted = false.obs;

  double get progress => _progress.value;
  int get currentMessageIndex => _currentMessageIndex.value;
  bool get isCompleted => _isCompleted.value;

  final List<String> loadingMessages = [
    'Nous téléchargeons les données…',
    'C\'est presque fini…',
    'Plus que quelques secondes avant d\'avoir le résultat…',
  ];

  Timer? _progressTimer;
  Timer? _messageTimer;

  void startProgress() {
    _progress.value = 0.0;
    _isCompleted.value = false;
    _currentMessageIndex.value = 0;

    _progressTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_progress.value >= 1.0) {
        timer.cancel();
        _isCompleted.value = true;
      } else {
        _progress.value += 0.02;
      }
    });
    _messageTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_isCompleted.value) {
        timer.cancel();
      } else {
        _currentMessageIndex.value =
            (_currentMessageIndex.value + 1) % loadingMessages.length;
      }
    });
  }

  void resetProgress() {
    _progress.value = 0.0;
    _isCompleted.value = false;
    _currentMessageIndex.value = 0;
    _progressTimer?.cancel();
    _messageTimer?.cancel();
  }

  @override
  void onClose() {
    _progressTimer?.cancel();
    _messageTimer?.cancel();
    super.onClose();
  }
}