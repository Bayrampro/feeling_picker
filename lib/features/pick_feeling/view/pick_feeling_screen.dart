import 'dart:io';

import 'package:feeling_picker/db/db.dart';
import 'package:feeling_picker/features/pick_feeling/view/stats_screen.dart';
import 'package:feeling_picker/providers/feelings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'widgets/widgets.dart';

class PickFeelingScreen extends ConsumerStatefulWidget {
  const PickFeelingScreen({super.key});

  @override
  ConsumerState<PickFeelingScreen> createState() => _PickFeelingScreenState();
}

class _PickFeelingScreenState extends ConsumerState<PickFeelingScreen> {
  bool _isDictionary = true;
  bool _isActive = false;
  double _currentStressLevel = 50;
  double _currentConfidenceLevel = 50;
  List<String>? _joySubfeelings;
  List<String>? _sadSubfeelings;
  List<String>? _scareSubfeelings;
  List<String>? _furiousSubfeelings;
  String _joySelectedEmotion = '';
  String _sadSelectedEmotion = '';
  String _scareSelectedEmotion = '';
  String _furiousSelectedEmotion = '';
  final noteText = TextEditingController();

  void _onSelected(bool isActive, List<String>? subfeelings, String name) {
    setState(() {
      _isActive = isActive;
      switch (name) {
        case 'Радость':
          if (subfeelings == null) {
            _joySelectedEmotion = '';
          }
          _joySubfeelings = subfeelings;
          break;
        case 'Грусть':
          if (subfeelings == null) {
            _sadSelectedEmotion = '';
          }
          _sadSubfeelings = subfeelings;
          break;
        case 'Страх':
          if (subfeelings == null) {
            _scareSelectedEmotion = '';
          }
          _scareSubfeelings = subfeelings;
          break;
        case 'Бешенство':
          if (subfeelings == null) {
            _furiousSelectedEmotion = '';
          }
          _furiousSubfeelings = subfeelings;
          break;
      }
    });
  }

  void _onSubmit() {
    ref.read(feelingsProvider.notifier).addFeeling(
          Mood(
            selectedMoods: [
              _joySelectedEmotion,
              _sadSelectedEmotion,
              _scareSelectedEmotion,
              _furiousSelectedEmotion,
            ],
            stressLevel: _currentStressLevel,
            selfRating: _currentConfidenceLevel,
          ),
        );
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Успех'),
          content: const Text('Запись успешно сохренена в Дневник настроения'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Успех'),
          content: const Text('Запись успешно сохренена в Дневник настроения'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru', null);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMMM HH:mm', 'ru').format(now);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverAppBar(
              surfaceTintColor: theme.canvasColor,
              title: Text(
                formattedDate,
                style: TextStyle(
                  color: theme.hintColor.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () => context.go('/calendar'),
                  icon: Icon(
                    Icons.calendar_month,
                    color: theme.hintColor.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: ScreenSwitchBar(
              isDictionary: _isDictionary,
              onPressed: () => setState(
                () => _isDictionary = !_isDictionary,
              ),
            ),
          ),
          _isDictionary
              ? SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Что чувствуешь?',
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: feelings.length,
                          itemBuilder: (context, index) => FeelingCard(
                            feeling: feelings[index],
                            onSelected: (isActive, subfeelings) => _onSelected(
                                isActive, subfeelings, feelings[index].name),
                          ),
                        ),
                      ),
                      if (_joySubfeelings != null)
                        SubfeelingsWrap(
                          subfeelings: _joySubfeelings!,
                          selectedEmotion: _joySelectedEmotion,
                          onSelected: (bool selected, String emotion) =>
                              setState(() => _joySelectedEmotion =
                                  selected ? emotion : ''),
                        ),
                      if (_sadSubfeelings != null)
                        SubfeelingsWrap(
                          subfeelings: _sadSubfeelings!,
                          selectedEmotion: _sadSelectedEmotion,
                          onSelected: (bool selected, String emotion) =>
                              setState(() => _sadSelectedEmotion =
                                  selected ? emotion : ''),
                        ),
                      if (_scareSubfeelings != null)
                        SubfeelingsWrap(
                          subfeelings: _scareSubfeelings!,
                          selectedEmotion: _scareSelectedEmotion,
                          onSelected: (bool selected, String emotion) =>
                              setState(() => _scareSelectedEmotion =
                                  selected ? emotion : ''),
                        ),
                      if (_furiousSubfeelings != null)
                        SubfeelingsWrap(
                          subfeelings: _furiousSubfeelings!,
                          selectedEmotion: _furiousSelectedEmotion,
                          onSelected: (bool selected, String emotion) =>
                              setState(() => _furiousSelectedEmotion =
                                  selected ? emotion : ''),
                        ),
                      LevelSlider(
                        title: 'Уровень стресса',
                        value: _currentStressLevel,
                        onChanged: (value) => setState(
                          () => _currentStressLevel = value,
                        ),
                        low: 'Низкий',
                        high: 'Высокий',
                      ),
                      LevelSlider(
                        title: 'Самооценка',
                        value: _currentConfidenceLevel,
                        onChanged: (value) => setState(
                          () => _currentConfidenceLevel = value,
                        ),
                        low: 'Неуверенность',
                        high: 'Уверенность',
                      ),
                      NoteInput(
                        noteText: noteText,
                      ),
                      SubmitButton(
                        onPressed: _onSubmit,
                      ),
                    ],
                  ),
                )
              : const SliverToBoxAdapter(child: StatsScreen()),
        ],
      ),
    );
  }
}
