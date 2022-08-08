import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';

extension UIExtension on num {
  get smh {
    num scale = this / AppConstants.desingHeight;
    num screenHeight = MediaQuery.of(
                NavigationService.instance.navigatorKey.currentContext!)
            .size
            .height -
        MediaQuery.of(NavigationService.instance.navigatorKey.currentContext!)
            .padding
            .top -
        MediaQuery.of(NavigationService.instance.navigatorKey.currentContext!)
            .padding
            .bottom;
    num result = screenHeight * scale;
    return result;
  }

  get smw {
    num scale = this / AppConstants.designWidth;
    num screenWidth = MediaQuery.of(
                NavigationService.instance.navigatorKey.currentContext!)
            .size
            .width -
        MediaQuery.of(NavigationService.instance.navigatorKey.currentContext!)
            .padding
            .left -
        MediaQuery.of(NavigationService.instance.navigatorKey.currentContext!)
            .padding
            .right;
    return screenWidth * scale;
  }
}
