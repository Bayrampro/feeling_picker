import 'package:feeling_picker/db/db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) => db.execute(
      'CREATE TABLE user_feelings(firstMood TEXT, secondMood TEXT, thirdMood TEXT, fourthMood TEXT, stressLevel REAL, selfRating REAL)',
    ),
    version: 1,
  );
  return db;
}

Future<void> _setDatabase(Mood mood) async {
  final db = await _getDatabase();
  db.insert('user_feelings', {
    'firstMood': mood.selectedMoods[0],
    'secondMood': mood.selectedMoods[1],
    'thirdMood': mood.selectedMoods[2],
    'fourthMood': mood.selectedMoods[3],
    'stressLevel': mood.stressLevel,
    'selfRating': mood.selfRating,
  });
}

class FeelingsNotifier extends StateNotifier<List<Mood>> {
  FeelingsNotifier() : super([]);

  Future<void> loadData() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final moods = data
        .map(
          (row) => Mood(
            selectedMoods: [
              row['firstMood'] as String,
              row['secondMood'] as String,
              row['thirdMood'] as String,
              row['fourthMood'] as String,
            ],
            stressLevel: row['stressLevel'] as double,
            selfRating: row['selfRating'] as double,
          ),
        )
        .toList();
    state = moods;
  }

  Future<void> addFeeling(Mood mood) async {
    await _setDatabase(mood);
    state = [mood, ...state];
  }

  Future<double> getAverageStressLevel() async {
    final db = await _getDatabase();
    final result = await db
        .rawQuery('SELECT AVG(stressLevel) as avg_stress FROM user_feelings');
    if (result.isEmpty || result.first['avg_stress'] == null) {
      return double.nan;
    }
    return result.first['avg_stress'] as double;
  }

  Future<double> getAverageSelfRating() async {
    final db = await _getDatabase();
    final result = await db
        .rawQuery('SELECT AVG(selfRating) as avg_rating FROM user_feelings');
    if (result.isEmpty || result.first['avg_rating'] == null) {
      return double.nan;
    }
    return result.first['avg_rating'] as double;
  }

  Future<Map<String, int>> getMoodFrequencies() async {
    final db = await _getDatabase();
    final moods = ['firstMood', 'secondMood', 'thirdMood', 'fourthMood'];
    final frequencies = <String, int>{};

    for (var mood in moods) {
      final result = await db.rawQuery(
          'SELECT $mood, COUNT(*) as count FROM user_feelings WHERE $mood != "" GROUP BY $mood');
      for (var row in result) {
        final moodValue = row[mood] as String;
        if (moodValue.isNotEmpty) {
          final count = row['count'] as int;
          frequencies[moodValue] = (frequencies[moodValue] ?? 0) + count;
        }
      }
    }
    return frequencies;
  }
}

final feelingsProvider = StateNotifierProvider<FeelingsNotifier, List<Mood>>(
  (ref) => FeelingsNotifier(),
);
