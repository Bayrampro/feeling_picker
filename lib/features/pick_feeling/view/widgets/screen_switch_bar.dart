import 'package:flutter/material.dart';

import 'widgets.dart';

class ScreenSwitchBar extends StatelessWidget {
  const ScreenSwitchBar({
    super.key,
    required this.isDictionary,
    required this.onPressed,
  });
  final bool isDictionary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: 40,
              width: mediaQuery.size.width * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: theme.hintColor.withOpacity(0.1),
              ),
            ),
            Positioned(
                left: 0,
                child: isDictionary
                    ? ActiveScreenSwitcher(
                        label: 'Дневник настроения',
                        onPressed: onPressed,
                        width: (mediaQuery.size.width * 0.75) * 0.65,
                        icon: Icons.book_rounded,
                      )
                    : UnActiveScreenSwitcher(
                        label: 'Дневник настроения',
                        onPressed: onPressed,
                        width: (mediaQuery.size.width * 0.75) * 0.65,
                        icon: Icons.book_rounded,
                      )),
            Positioned(
              right: 0,
              child: isDictionary
                  ? UnActiveScreenSwitcher(
                      label: 'Статистика',
                      icon: Icons.bar_chart,
                      width: (mediaQuery.size.width * 0.75) * 0.43,
                      onPressed: onPressed,
                    )
                  : ActiveScreenSwitcher(
                      label: 'Статистика',
                      onPressed: onPressed,
                      width: (mediaQuery.size.width * 0.75) * 0.43,
                      icon: Icons.bar_chart,
                    ),
            )
          ],
        ),
      ],
    );
  }
}
