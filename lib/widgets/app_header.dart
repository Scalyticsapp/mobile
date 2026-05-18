import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/theme/app_theme.dart';

class AppHeader
    extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  final List<Widget>? actions;

  const AppHeader({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return AppBar(
      backgroundColor:
          AppColors.bg,

      elevation: 0,

      scrolledUnderElevation:
          0,

      automaticallyImplyLeading:
          false,

      leading: GestureDetector(
        onTap: () {
          Get.back();
        },

        child: const Icon(
          Icons
              .arrow_back_ios_new_rounded,

          size: 18,

          color:
              AppColors.textPrimary,
        ),
      ),

      centerTitle: true,

      title: Text(
        title,

        style:
            AppText.body.copyWith(
          fontWeight:
              FontWeight.w600,
        ),
      ),

      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(
        kToolbarHeight,
      );
}