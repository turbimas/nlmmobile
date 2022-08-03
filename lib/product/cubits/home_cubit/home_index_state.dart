part of 'home_index_cubit.dart';

@immutable
abstract class HomeIndexState {
  final int sayac;
  const HomeIndexState(this.sayac);
}

class HomeIndexInitial extends HomeIndexState {
  const HomeIndexInitial(int sayac) : super(sayac);
}
