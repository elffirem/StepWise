part of 'mood_selection_view.dart';

mixin MoodSelectionMixin on State<MoodSelectionView> {
 final List<Map<String, String>> moods = [
    {'mood': 'Anxious', 'imagePath': 'assets/images/emotions/anxious.png'},
    {'mood': 'Joy', 'imagePath': 'assets/images/emotions/joy.png'},
    {'mood': 'Anger', 'imagePath': 'assets/images/emotions/anger.png'},
    {'mood': 'Calm', 'imagePath': 'assets/images/emotions/calm.png'},
    {'mood': 'Sadness', 'imagePath': 'assets/images/emotions/sadness.png'},
    {'mood': 'Excited', 'imagePath': 'assets/images/emotions/excited.png'},
  ];

}