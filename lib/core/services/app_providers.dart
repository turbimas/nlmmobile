import 'package:nlmmobile/product/providers/home_index_provider.dart';
import 'package:riverpod/riverpod.dart';

class AppProviders {
  static late StateNotifierProvider<HomeIndexProvider, int> _homeIndexProvider;
  static StateNotifierProvider<HomeIndexProvider, int> get homeIndexProvider =>
      _homeIndexProvider;

  AppProviders() {
    _homeIndexProvider = StateNotifierProvider<HomeIndexProvider, int>(
        (ref) => HomeIndexProvider());
  }
}
