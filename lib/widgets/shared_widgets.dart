import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Dark card container
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double radius;
  final Color? color;
  final Color? borderColor;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.radius = 14,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? AppColors.s2,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? AppColors.border,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

/// Pill badge
class AppPill extends StatelessWidget {
  final String label;
  final Color color;
  final Color borderColor;
  final Color textColor;

  const AppPill({
    super.key,
    required this.label,
    required this.color,
    required this.borderColor,
    required this.textColor,
  });

  factory AppPill.green(String label) => AppPill(
        label: label,
        color: const Color(0x1AC8F064),
        borderColor: const Color(0x40C8F064),
        textColor: AppColors.accent,
      );

  factory AppPill.yellow(String label) => AppPill(
        label: label,
        color: const Color(0x1AF0C96B),
        borderColor: const Color(0x4DF0C96B),
        textColor: AppColors.yellow,
      );

  factory AppPill.red(String label) => AppPill(
        label: label,
        color: const Color(0x1AE8594C),
        borderColor: const Color(0x4DE8594C),
        textColor: AppColors.red,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: AppText.caption.copyWith(
          color: textColor,
          fontSize: 10,
        ),
      ),
    );
  }
}

/// 🔥 NAVBAR FINAL (NO ANIMATION, NO BOUNCE)
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    {'icon': Icons.home_rounded, 'label': 'Beranda'},
    {'icon': Icons.document_scanner_rounded, 'label': 'Scan'},
    {'icon': Icons.show_chart_rounded, 'label': 'Progres'},
    {'icon': Icons.person_rounded, 'label': 'Profil'},
  ];

  @override
  Widget build(BuildContext context) {

    final bottomInset =
        MediaQuery.of(context).padding.bottom;

    return Container(
      height: 68 + bottomInset,
      padding: EdgeInsets.only(
        bottom: bottomInset,
      ),

      decoration: BoxDecoration(
        color: AppColors.bg,
      ),

      child: Row(
        children: List.generate(
          _items.length,
          (i) {

            final isActive =
                currentIndex == i;

            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(i),
                behavior:
                    HitTestBehavior.opaque,

                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Transform.translate(
                      offset: Offset(
                        0,
                        _items[i]['icon'] ==
                                Icons.document_scanner_rounded
                            ? 2
                            : 0,
                      ),

                      child: Icon(
                        _items[i]['icon']
                            as IconData,

                      color: isActive
                          ? AppColors.accent
                          : AppColors.muted,

                      size:
                          _items[i]['icon'] ==
                                  Icons
                                      .document_scanner_rounded
                              ? 18
                              : 22,
                    ),
                    ),

                    const SizedBox(height: 4),

                    Transform.translate(
                      offset: Offset(
                        0,
                        _items[i]['label'] == 'Scan'
                            ? 3
                            : 0,
                      ),

                      child: Text(
                        _items[i]['label']
                            as String,

                      style:
                          AppText.label.copyWith(
                        color: isActive
                            ? AppColors.accent
                            : AppColors.muted,

                        fontSize: 9,
                      ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds: 180,
                      ),

                      width: 4,
                      height: 4,

                      decoration:
                          BoxDecoration(
                        color: isActive
                            ? AppColors.accent
                            : Colors.transparent,

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

class BackgroundGlow extends StatelessWidget {
  const BackgroundGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        /// TOP LEFT
        Positioned(
          top: -100,
          left: -120,
          child: Container(
            width: 360,
            height: 360,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accent.withOpacity(0.16),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        /// BOTTOM RIGHT
        Positioned(
          bottom: -120,
          right: -80,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accent.withOpacity(0.10),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Condition progress card
class ConditionCard extends StatelessWidget {
  final String name;
  final String scientific;
  final double percent;
  final String cause;
  final Color color;

  const ConditionCard({
    super.key,
    required this.name,
    required this.scientific,
    required this.percent,
    required this.cause,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: AppText.body.copyWith(
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(scientific,
                      style: AppText.caption.copyWith(fontSize: 10)),
                ],
              ),
              Text(
                '${percent.toInt()}%',
                style: AppText.heading.copyWith(
                  fontSize: 22,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: const Color(0x14FFFFFF),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.border),
              ),
            ),
            child: Text(
              cause,
              style: AppText.caption.copyWith(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

/// Section title
class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text.toUpperCase(),
        style: AppText.label.copyWith(letterSpacing: 1.4),
      ),
    );
  }
}