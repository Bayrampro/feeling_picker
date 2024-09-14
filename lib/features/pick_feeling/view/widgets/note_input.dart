import 'package:flutter/material.dart';

class NoteInput extends StatelessWidget {
  const NoteInput({super.key, required this.noteText});

  final TextEditingController noteText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Заметки',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16.0),
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: theme.hintColor.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              maxLines: null,
              controller: noteText,
              decoration: InputDecoration(
                label: const Text('Напиши заметку....'),
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle: TextStyle(
                    color: theme.hintColor.withOpacity(0.3),
                    fontWeight: FontWeight.w100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
