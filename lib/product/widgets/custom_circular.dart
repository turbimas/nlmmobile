import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: CustomColors.primary,
      color: CustomColors.primaryText,
      strokeWidth: 5,
    );
  }
}
