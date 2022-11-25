import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:nlmmobile/product/cubits/home_index_cubit/home_index_cubit.dart';
import 'package:nlmmobile/view/auth/login/login_view.dart';
import 'package:nlmmobile/view/main/categories/categories_view.dart';
import 'package:nlmmobile/view/main/favorites/favorites_view.dart';
import 'package:nlmmobile/view/main/home/home_view.dart';
import 'package:nlmmobile/view/main/profile/profile_view.dart';
import 'package:nlmmobile/view/order/basket/basket_view.dart';
=======
import 'package:koyevi/product/cubits/home_index_cubit/home_index_cubit.dart';
import 'package:koyevi/view/auth/login/login_view.dart';
import 'package:koyevi/view/main/categories/categories_view.dart';
import 'package:koyevi/view/main/favorites/favorites_view.dart';
import 'package:koyevi/view/main/home/home_view.dart';
import 'package:koyevi/view/main/profile/profile_view.dart';
import 'package:koyevi/view/order/basket/basket_view.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class MainViewModel extends ChangeNotifier {
  Widget? activePage(BuildContext context) {
    switch (context.watch<HomeIndexCubit>().state.counter) {
      case 0:
        return const CategoriesView();
      case 1:
        return const FavoritesView();
      case 2:
        return const HomeView();
      case 3:
        return const BasketView();
      case 4:
        return const ProfileView();
      default:
        return const LoginView();
    }
  }
}
