import 'package:feeling_picker/router/router.dart';
import 'package:flutter/material.dart';

import '../ui/ui.dart';

class FeelingPickerApp extends StatelessWidget {
  const FeelingPickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Feeling Picker',
      theme: theme,
      routerConfig: router,
    );
  }
}
