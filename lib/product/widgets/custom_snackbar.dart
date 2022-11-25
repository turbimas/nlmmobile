import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
=======
import 'package:koyevi/core/services/theme/custom_colors.dart';
import 'package:koyevi/core/services/theme/custom_fonts.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class CustomSnackBar extends StatelessWidget {
  final String text;
  final bool error;
  const CustomSnackBar({super.key, required this.text, this.error = false});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content: Text(text,
            style: CustomFonts.bodyText4(
                error ? CustomColors.cancelText : CustomColors.primaryText)),
        backgroundColor: error ? CustomColors.cancel : CustomColors.primary);
  }
}
