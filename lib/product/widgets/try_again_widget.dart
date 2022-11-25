// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
=======
import 'package:koyevi/core/services/localization/locale_keys.g.dart';
import 'package:koyevi/core/services/theme/custom_colors.dart';
import 'package:koyevi/core/services/theme/custom_fonts.dart';
import 'package:koyevi/core/services/theme/custom_theme_data.dart';
import 'package:koyevi/core/utils/extensions/ui_extensions.dart';
import 'package:koyevi/product/widgets/custom_text.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class TryAgain extends StatelessWidget {
  final void Function() callBack;
  const TryAgain({required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: callBack,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.primary),
            borderRadius: CustomThemeData.fullInfiniteRounded,
          ),
          height: 50.smh,
          width: 300.smw,
          child: Center(
            child: CustomTextLocale(
              LocaleKeys.TryAgainWidget_try_again,
              style: CustomFonts.bigButton(CustomColors.backgroundText),
            ),
          ),
        ),
      ),
    );
  }
}
