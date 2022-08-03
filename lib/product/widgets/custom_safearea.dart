import 'package:flutter/cupertino.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';

class CustomSafearea extends StatelessWidget {
  final Widget child;
  const CustomSafearea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: CustomThemeData.scaffoldBackgroundGradinetColors,
        ),
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}
