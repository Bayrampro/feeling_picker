import 'package:flutter/material.dart';

class LevelSlider extends StatelessWidget {
  const LevelSlider({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.low,
    required this.high,
  });

  final String title;
  final double value;
  final void Function(double) onChanged;
  final String low;
  final String high;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: theme.hintColor.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => Text(
                  '|',
                  style: TextStyle(
                      fontSize: 18, color: theme.hintColor.withOpacity(0.3)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: theme.primaryColor,
                inactiveTrackColor: theme.hintColor.withOpacity(0.3),
                trackHeight: 4.0,
                thumbColor: theme.primaryColor,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 12.0,
                ),
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 16.0,
                ),
                overlayColor: theme.primaryColor.withOpacity(0.6),
                tickMarkShape: const RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.transparent,
                inactiveTickMarkColor: theme.hintColor.withOpacity(0.3),
              ),
              child: Slider(
                value: value,
                min: 0,
                max: 100,
                divisions: 5,
                onChanged: onChanged,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  low,
                  style: TextStyle(
                      fontSize: 16, color: theme.hintColor.withOpacity(0.3)),
                ),
                Text(
                  high,
                  style: TextStyle(
                      fontSize: 16, color: theme.hintColor.withOpacity(0.3)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
