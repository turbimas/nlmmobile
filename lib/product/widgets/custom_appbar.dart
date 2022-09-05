import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';

class CustomAppBar {
  static PreferredSize activeBack(String title) => PreferredSize(
        preferredSize: Size.fromHeight(50.smh),
        child: AppBar(
          backgroundColor: CustomColors.primary,
          title: Text(title, style: GoogleFonts.inder(fontSize: 20.sp)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () =>
                Navigator.pop(NavigationService.navigatorKey.currentContext!),
          ),
        ),
      );

  static PreferredSize inactiveBack(String title) => PreferredSize(
        preferredSize: Size.fromHeight(50.smh),
        child: AppBar(
          backgroundColor: CustomColors.primary,
          title: Text(title, style: GoogleFonts.inder(fontSize: 20.sp)),
          centerTitle: true,
          leading: const SizedBox(),
        ),
      );
}
