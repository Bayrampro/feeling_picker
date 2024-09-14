class Mood {
  Mood({
    this.note,
    required this.selectedMoods,
    required this.stressLevel,
    required this.selfRating,
  });

  final List<String> selectedMoods;
  final double stressLevel;
  final double selfRating;
  final String? note;
}
