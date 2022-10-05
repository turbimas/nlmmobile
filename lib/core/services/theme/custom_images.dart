// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nlmmobile/core/services/theme/theme_manager.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';

abstract class CustomImages {
  static late final Widget basket_empty;
  static late final Widget forgot_password;
  static late final Widget validation_image;
  static late final Widget login;
  static late final Widget register;
  static late final Widget splash;
  static late final Widget basket_done;
  static late final Widget return_done;
  static late final Widget cancel_done;
  static late final Widget tr_flag;
  static late final Widget en_flag;
  static late final Widget ar_flag;
  static late final Widget image_not_found;

  static void loadImages() {
    basket_empty = _image("basket_empty");
    forgot_password = _image("forgot_password");
    validation_image = _image("validation_image");
    login = _image("login");
    register = _image("register");
    splash = _image("splash");
    basket_done = _image("basket_done");
    return_done = _image("return_done");
    cancel_done = _image("cancel_done");
    tr_flag = _image("tr_flag");
    en_flag = _image("en_flag");
    ar_flag = _image("ar_flag");
    image_not_found = _image("image_not_found");
  }

  static Widget _image(String name) {
    bool isVector = AppTheme.imageData[name]["type"] == "vector";
    var path = AppTheme.imageData[name]["path"];
    var width = (AppTheme.imageData[name]["width"] as int).smw;
    var height = (AppTheme.imageData[name]["height"] as int).smh;

    if (isVector) {
      return SvgPicture.asset(path, height: height, width: width);
      // SizedBox(
      //     height: height,
      //     width: width,
      //     child: SvgPicture.asset(path, height: height, width: width));
      // return Center(
      //   child: ConstrainedBox(
      //       constraints: BoxConstraints(
      //         maxWidth: width,
      //         maxHeight: height,
      //         minWidth: width,
      //         minHeight: height,
      //       ),
      //       child: SvgPicture.asset(path, height: height, width: width)),
      // );
    } else {
      return Image.asset(path, width: width, height: height);
    }
  }
}
