import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_index_state.dart';

class HomeIndexCubit extends Cubit<HomeIndexState> {
  HomeIndexCubit() : super(const HomeIndexInitial(2));

  void set(int sayac) {
    emit(HomeIndexInitial(sayac));
    log('HomeIndexCubit: set: $sayac');
  }
}
