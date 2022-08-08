import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/theme/app_theme.dart';
import 'package:nlmmobile/view/main/main_view.dart';

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

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainView(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (AppTheme.appTheme == null) {
      AppTheme.appTheme = AppTheme.themeData;
      widget.setstate();
    }
    return const Scaffold(
      body: Center(
        child: Text("Splash view"),
      ),
    );
  }
}
