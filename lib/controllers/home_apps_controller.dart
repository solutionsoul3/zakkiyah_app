import 'package:get/get.dart';

class HomeAppsController extends GetxController {
  HomeAppsController();

  static const List<String> allLabels = <String>[
    'Talk',
    'Schedule',
    'Type',
    'Media',
    'Therapy',
    'Draw',
    'Learn',
    'Read',
    'Shapes',
    'Daily Routine',
    'Alphabet',
    'Numbers',
    'Colors',
    'Sign Language',
    'Feelings',
    'Important',
    'Conversational Phrases',
    'Daily Activities',
    'ICU Communication',
    'Emergency Response',
    'Simple Communication',
    'Mental Health',
    'Pain Scale',
  ];

  final RxSet<String> _enabledLabels = <String>{...allLabels}.obs;

  bool isEnabled(String label) => _enabledLabels.contains(label);

  Set<String> get enabledLabels => _enabledLabels;

  List<String> get availableLabels => allLabels;

  void setEnabled(String label, bool enabled) {
    if (!allLabels.contains(label)) return;
    if (enabled) {
      _enabledLabels.add(label);
    } else {
      _enabledLabels.remove(label);
    }
    _enabledLabels.refresh();
  }
}
