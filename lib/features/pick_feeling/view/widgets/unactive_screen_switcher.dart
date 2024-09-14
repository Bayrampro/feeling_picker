import 'package:flutter/material.dart';

class UnActiveScreenSwitcher extends StatelessWidget {
  const UnActiveScreenSwitcher({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    required this.width,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData icon;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: width,
      child: TextButton.icon(
        onPressed: onPressed,
        label: Text(
          label,
          style: TextStyle(
            color: theme.canvasColor,
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
        ),
        icon: Icon(
          icon,
          color: theme.canvasColor,
          size: 18,
        ),
      ),
    );
  }
}
