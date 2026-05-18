import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    {
      'icon': Icons.home_rounded,
      'label': 'Beranda',
    },
    {
      'icon': Icons.document_scanner_rounded,
      'label': 'Scan',
    },
    {
      'icon': Icons.show_chart_rounded,
      'label': 'Progres',
    },
    {
      'icon': Icons.person_rounded,
      'label': 'Profil',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 68 + bottomInset,
      padding: EdgeInsets.only(
        bottom: bottomInset,
      ),
      decoration: const BoxDecoration(
        color: AppColors.bg,
      ),
      child: Row(
        children: List.generate(
          _items.length,
          (i) {
            final isActive = currentIndex == i;

            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(
                        0,
                        _items[i]['icon'] == Icons.document_scanner_rounded
                            ? 2
                            : 0,
                      ),
                      child: Icon(
                        _items[i]['icon'] as IconData,
                        color: isActive ? AppColors.accent : AppColors.muted,
                        size:
                            _items[i]['icon'] == Icons.document_scanner_rounded
                                ? 18
                                : 22,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Transform.translate(
                      offset: Offset(
                        0,
                        _items[i]['label'] == 'Scan' ? 3 : 0,
                      ),
                      child: Text(
                        _items[i]['label'] as String,
                        style: AppText.label.copyWith(
                          color: isActive ? AppColors.accent : AppColors.muted,
                          fontSize: 9,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 180,
                      ),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.accent : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
