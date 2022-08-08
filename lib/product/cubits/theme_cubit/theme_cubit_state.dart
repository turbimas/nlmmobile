part of 'theme_cubit_cubit.dart';

@immutable
abstract class ThemeCubitState {
  final ThemeData? theme;
  const ThemeCubitState(this.theme);
}

class ThemeCubitInitial extends ThemeCubitState {
  const ThemeCubitInitial(ThemeData? theme) : super(theme);
}
