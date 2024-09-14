import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 50),
          backgroundColor: theme.primaryColor,
          foregroundColor: theme.canvasColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Скругленные углы
          ),
        ),
        child: const Text('Сохранить'),
      ),
    );
  }
}
