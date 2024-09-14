import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/feelings_provider.dart'; // Импортируйте ваш провайдер
import 'widgets/widgets.dart'; // Импортируйте ваши виджеты

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feelingsNotifier = ref.watch(feelingsProvider.notifier);

    return FutureBuilder(
      future: Future.wait([
        feelingsNotifier.getAverageStressLevel(),
        feelingsNotifier.getAverageSelfRating(),
        feelingsNotifier.getMoodFrequencies(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Нет данных для отображения'));
        }

        final data = snapshot.data as List<dynamic>;
        final averageStressLevel = data[0];
        final averageSelfRating = data[1];
        final moodFrequencies = data[2] as Map<String, int>;

        if (averageStressLevel.isNaN || averageSelfRating.isNaN) {
          return const Center(child: Text('Нет данных для отображения'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              StatCard(
                title: 'Средний уровень стресса',
                value: averageStressLevel,
              ),
              StatCard(
                title: 'Средний саморейтинг',
                value: averageSelfRating,
              ),
              MoodFrequencyCard(moodFrequencies: moodFrequencies),
            ],
          ),
        );
      },
    );
  }
}
