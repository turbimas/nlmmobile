import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_images.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/models/user_model.dart';
import 'package:nlmmobile/view/auth/login/login_view.dart';

class SplashView extends ConsumerStatefulWidget {
  final Function setstate;
  const SplashView({Key? key, required this.setstate}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double value = 0;
  final Duration _duration = const Duration(seconds: 1);

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: _duration,
        value: 1,
        reverseDuration: _duration,
        lowerBound: 0.5,
        upperBound: 1);

    _controller.addListener(_listenerAction);
    _controller.animateTo(0.5);
    CustomColors.loadColors();
    CustomIcons.loadIcons();
    CustomImages.loadImages();
    // AuthService.currentUser = null;
    // CacheManager.instance.remove(CacheConstants.userId);
    // CacheManager.instance.remove(CacheConstants.userEmail);
    if (AuthService.isLoggedIn) {
      try {
        NetworkService.get("api/users/user_info/${AuthService.email}")
            .then((ResponseModel value) {
          if (value.success) {
            AuthService.login(UserModel.fromJson(value.data));
          } else {
            AuthService.logout();
            PopupHelper.showErrorDialog(errorMessage: value.errorMessage);
          }
        }).onError((error, stackTrace) {
          AuthService.logout();
          PopupHelper.showErrorDialogWithCode(error!);
        });
      } catch (e) {
        PopupHelper.showErrorDialogWithCode(e);
        AuthService.logout();
      }
    } else {
      Future.delayed(Duration.zero, () {
        _controller.stop();
        NavigationService.navigateToPageReplace(const LoginView());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: AppConstants.designWidth,
            height: AppConstants.designHeight,
            child: Opacity(opacity: value, child: CustomImages.splash)),
      ),
    );
  }

  _listenerAction() {
    if (mounted) {
      setState(() {
        value = _controller.value;
      });
      if (value == 1) {
        _controller.reverse();
      } else if (value == 0.5) {
        _controller.forward();
      }
    }
  }
}
