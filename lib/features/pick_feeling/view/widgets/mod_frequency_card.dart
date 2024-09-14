import 'package:flutter/material.dart';

class MoodFrequencyCard extends StatelessWidget {
  final Map<String, int> moodFrequencies;

  const MoodFrequencyCard({
    super.key,
    required this.moodFrequencies,
  });

  @override
  Widget build(BuildContext context) {
    final filteredEntries =
        moodFrequencies.entries.where((entry) => entry.key.isNotEmpty).toList();
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Частота настроений',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...filteredEntries.map(
              (entry) => ListTile(
                title: Text(entry.key),
                trailing: Text(entry.value.toString()),
              ),
            ),
            if (filteredEntries.isEmpty)
              const Center(child: Text('Нет доступных настроений')),
          ],
        ),
      ),
    );
  }
}
