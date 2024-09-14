import 'package:feeling_picker/features/calendar/calendar.dart';
import 'package:feeling_picker/features/pick_feeling/pick_feeling.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PickFeelingScreen(),
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => CalendarScreen(),
    ),
  ],
);
