import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
=======
import 'package:koyevi/core/services/navigation/navigation_service.dart';
import 'package:koyevi/product/constants/app_constants.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

extension UIExtension on num {
  get smh {
    num scale = this / AppConstants.designHeight;
    num screenHeight =
        MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                .size
                .height -
            MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                .padding
                .top -
            MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                .padding
                .bottom;
    num result = screenHeight * scale;
    return result;
  }

  get smw {
    num scale = this / AppConstants.designWidth;
    num screenWidth =
        MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                .size
                .width -
            MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                .padding
                .left -
            MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                .padding
                .right;
    return screenWidth * scale;
  }
}
