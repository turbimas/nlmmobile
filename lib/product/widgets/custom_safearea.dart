import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
=======
import 'package:koyevi/core/services/theme/custom_colors.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class CustomSafeArea extends StatelessWidget {
  final Widget child;
  const CustomSafeArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.primary,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              top: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: CustomColors.background,
                    ),
                  ),
                  child: child),
            ),
          ],
        ),
      ),
    );
  }
}
