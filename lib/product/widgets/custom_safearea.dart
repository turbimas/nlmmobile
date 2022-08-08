import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;
  const CustomSafeArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0E5B28),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              top: 0,
              right: 0,
              child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: CustomThemeData.scaffoldBackgroundGradientColors,
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
