import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nlmmobile/core/services/theme/app_theme.dart';
import 'package:nlmmobile/view/main/main_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainView()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
            designSize: Size(360, 800 + MediaQuery.of(context).padding.top))
        .then((value) {
      AppTheme.appTheme = AppTheme.themeData;
    });
    return Scaffold(
      body: Center(
        child: Text("Splash view", style: TextStyle(fontSize: 25.sp)),
      ),
    );
  }
}
