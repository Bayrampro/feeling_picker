import 'package:flutter/material.dart';

import '../../../../db/db.dart';

class FeelingCard extends StatefulWidget {
  const FeelingCard({
    super.key,
    required this.feeling,
    required this.onSelected,
  });

  final Feeling feeling;
  final void Function(bool, List<String>?) onSelected;

  @override
  State<FeelingCard> createState() => _FeelingCardState();
}

class _FeelingCardState extends State<FeelingCard> {
  bool isActive = false;
  void _onTap() => setState(() {
        isActive = !isActive;
        if (!isActive) {
          widget.onSelected(isActive, null);
          return;
        }
        widget.onSelected(isActive, widget.feeling.subfeelings);
      });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(60),
            border: isActive ? Border.all(color: theme.primaryColor) : null,
            boxShadow: [
              BoxShadow(
                color: theme.hintColor.withOpacity(0.12),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(
                    widget.feeling.imagePath,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.feeling.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
