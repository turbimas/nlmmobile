import 'package:nlmmobile/core/services/cache/cache_manager.dart';
import 'package:nlmmobile/product/constants/cache_constants.dart';
import 'package:nlmmobile/product/models/user_model.dart';

class AuthService {
  static UserModel? currentUser;
  static bool get isLoggedIn => true;
  // CacheManager.instance.getString(CacheConstants.userId) != null;
  static set setCurrentUser(UserModel user) {
    currentUser = user;
    CacheManager.instance.setString(CacheConstants.userId, user.id);
  }

  static void logout() {
    CacheManager.instance.remove(CacheConstants.userId);
    currentUser = null;
  }
}
