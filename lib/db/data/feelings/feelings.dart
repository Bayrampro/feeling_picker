import 'package:feeling_picker/db/models/models.dart';

final feelings = [
  Feeling(
    name: 'Радость',
    imagePath: 'assets/super.png',
    subfeelings: [
      'Возбуждение',
      'Восторг',
      'Игривость',
      'Наслаждение',
      'Очарование',
      'Осознанность',
      'Смелость',
      'Удовольствие',
      'Чувственность',
      'Энергичность',
      'Экстравагантность',
    ],
  ),
  Feeling(
    name: 'Грусть',
    imagePath: 'assets/not-bad.png',
    subfeelings: [
      'Одиночество',
      'Печаль',
      'Разочарование',
      'Тоска',
      'Опустошённость',
      'Грусть',
      'Отчаяние',
      'Сожаление',
      'Уныние',
      'Обессиленность',
      'Тревога',
      'Ущемленность'
    ],
  ),
  Feeling(
    name: 'Страх',
    imagePath: 'assets/bad.png',
    subfeelings: [
      'Тревога',
      'Паника',
      'Беспокойство',
      'Ужас',
      'Неуверенность',
      'Опасение',
      'Нервозность',
      'Трепет',
      'Испуг',
      'Оцепенение',
      'Паранойя',
      'Страх неизвестности'
    ],
  ),
  Feeling(
    name: 'Бешенство',
    imagePath: 'assets/awful.png',
    subfeelings: [
      'Злость',
      'Гнев',
      'Ярость',
      'Раздражение',
      'Агрессия',
      'Ненависть',
      'Озлобленность',
      'Враждебность',
      'Обида',
      'Фрустрация',
      'Беспомощность',
      'Нетерпимость'
    ],
  ),
];
