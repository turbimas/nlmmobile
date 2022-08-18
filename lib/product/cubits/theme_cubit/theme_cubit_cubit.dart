import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_cubit_state.dart';

class ThemeCubitCubit extends Cubit<ThemeCubitState> {
  ThemeCubitCubit() : super(const ThemeCubitInitial(null)) {
    log("ThemeCubitCubit");
  }

  void changeTheme(ThemeData theme) {
    emit(ThemeCubitInitial(theme));
  }
}
