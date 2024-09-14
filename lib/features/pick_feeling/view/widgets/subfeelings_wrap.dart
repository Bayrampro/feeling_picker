import 'package:flutter/material.dart';

class SubfeelingsWrap extends StatelessWidget {
  const SubfeelingsWrap({
    super.key,
    required this.subfeelings,
    required this.selectedEmotion,
    required this.onSelected,
  });

  final List<String> subfeelings;
  final String selectedEmotion;
  final void Function(bool, String) onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: subfeelings.map((emotion) {
          return ChoiceChip(
            label: Text(emotion),
            labelStyle: TextStyle(
              color: selectedEmotion == emotion ? Colors.white : Colors.black,
            ),
            backgroundColor: Colors.white,
            selectedColor: theme.primaryColor,
            selected: selectedEmotion == emotion,
            onSelected: (value) => onSelected(value, emotion),
          );
        }).toList(),
      ),
    );
  }
}
