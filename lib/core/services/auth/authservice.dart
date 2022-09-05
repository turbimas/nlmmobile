import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nlmmobile/core/services/cache/cache_manager.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/product/constants/cache_constants.dart';
import 'package:nlmmobile/product/cubits/home_index_cubit/home_index_cubit.dart';
import 'package:nlmmobile/product/models/user_model.dart';
import 'package:nlmmobile/product/widgets/main/main_view.dart';
import 'package:nlmmobile/view/auth/login/login_view.dart';

class AuthService {
  static UserModel? currentUser;
  static bool get isLoggedIn =>
      CacheManager.instance.getInt(CacheConstants.userId) != null;

  static String? get email => currentUser != null
      ? currentUser!.email
      : CacheManager.instance.getString(CacheConstants.userEmail);

  static login(UserModel user) {
    currentUser = user;
    CacheManager.instance.setInt(CacheConstants.userId, user.id);
    CacheManager.instance.setString(CacheConstants.userEmail, user.email);
    NavigationService.navigateToPageAndRemoveUntil(const MainView());
  }

  static void logout() {
    CacheManager.instance.remove(CacheConstants.userId);
    CacheManager.instance.remove(CacheConstants.userEmail);
    currentUser = null;
    NavigationService.context.read<HomeIndexCubit>().set(2);
    NavigationService.navigateToPageAndRemoveUntil(const LoginView());
  }
}
