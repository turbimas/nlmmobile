import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nlmmobile/core/initializations.dart';
import 'package:nlmmobile/core/services/navigation/navigation_route.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/app_theme.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/cubits/home_index_cubit/home_index_cubit.dart';
import 'package:nlmmobile/view/auth/splash/splash_view.dart';

void main(List<String> args) {
  mainInit();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeIndexCubit(),
      child: ProviderScope(
        child: ScreenUtilInit(
          designSize: AppConstants.designSize,
          builder: (context, child) => child!,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appTheme,
            routes: NavigationRoute.instance.routes,
            navigatorKey: NavigationService.navigatorKey,
            home: SplashView(setstate: setstateCallback),
          ),
        ),
      ),
    );
  }

  void setstateCallback() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }
}
