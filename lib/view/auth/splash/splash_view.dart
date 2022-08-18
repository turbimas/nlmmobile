import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/initializations.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/app_theme.dart';
import 'package:nlmmobile/product/constants/navigation_constants.dart';

class SplashView extends ConsumerStatefulWidget {
  final Function setstate;
  const SplashView({Key? key, required this.setstate}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    if (AppTheme.appTheme == null) {
      AppTheme.appTheme = AppTheme.themeData;
      widget.setstate();
    }
    initAsync().then((value) {
      if (AuthService.isLoggedIn) {
        NavigationService.navigateToName(NavigationConstants.mainView);
      } else {
        NavigationService.navigateToName(NavigationConstants.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash view"),
      ),
    );
  }
}
