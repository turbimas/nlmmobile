import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';

class CustomAppBar {
  static PreferredSize activeBack(String title) => PreferredSize(
        preferredSize: Size.fromHeight(50.smh),
        child: AppBar(
          title: Text(title),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(
                NavigationService.instance.navigatorKey.currentContext!),
          ),
        ),
      );

  static PreferredSize inactiveBack(String title) => PreferredSize(
        preferredSize: Size.fromHeight(50.smh),
        child: AppBar(
          title: Text(title),
          centerTitle: true,
          leading: const SizedBox(),
        ),
      );
}
