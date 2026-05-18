import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class SectionTitle
    extends StatelessWidget {
  final String text;

  const SectionTitle(
    this.text, {
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      text.toUpperCase(),

      style:
          AppText.sectionTitle,
    );
  }
}