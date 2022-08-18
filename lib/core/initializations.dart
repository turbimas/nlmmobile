import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nlmmobile/core/services/cache/cache_manager.dart';

void mainInit() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      systemNavigationBarDividerColor: Colors.transparent));
}

void initSync() {}

Future initAsync() async {
  await CacheManager.initCache();
}
