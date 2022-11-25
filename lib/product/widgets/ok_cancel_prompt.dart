import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
=======
import 'package:koyevi/core/services/localization/locale_keys.g.dart';
import 'package:koyevi/core/services/theme/custom_colors.dart';
import 'package:koyevi/core/services/theme/custom_fonts.dart';
import 'package:koyevi/core/services/theme/custom_icons.dart';
import 'package:koyevi/core/utils/extensions/ui_extensions.dart';
import 'package:koyevi/product/constants/app_constants.dart';
import 'package:koyevi/product/widgets/custom_text.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class OkCancelPrompt extends StatelessWidget {
  final void Function() okCallBack;
  final void Function() cancelCallBack;
  late final bool forPopup;
  OkCancelPrompt(
      {Key? key, required this.okCallBack, required this.cancelCallBack})
      : super(key: key) {
    forPopup = false;
  }
  OkCancelPrompt.forPopup(
      {Key? key, required this.okCallBack, required this.cancelCallBack})
      : super(key: key) {
    forPopup = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.designWidth.smw,
      height: 50.smh,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              cancelCallBack.call();
            },
            child: Container(
              height: 50.smh,
              width: !forPopup ? (AppConstants.designWidth / 2).smw : 165.smw,
              color: CustomColors.cancel,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIcons.cancel_icon__medium,
                  CustomTextLocale(LocaleKeys.OkCancelPrompt_cancel,
                      style: CustomFonts.bigButton(CustomColors.secondaryText)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              okCallBack.call();
            },
            child: Container(
              height: 50.smh,
              width: !forPopup ? (AppConstants.designWidth / 2).smw : 165.smw,
              color: CustomColors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIcons.check_icon,
                  CustomTextLocale(LocaleKeys.OkCancelPrompt_ok,
                      style: CustomFonts.bigButton(CustomColors.secondaryText)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
