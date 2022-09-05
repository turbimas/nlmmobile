import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';

class OkCancelPrompt extends StatelessWidget {
  final void Function() okCallBack;
  final void Function() cancelCallBack;
  const OkCancelPrompt(
      {Key? key, required this.okCallBack, required this.cancelCallBack})
      : super(key: key);

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
              width: (AppConstants.designWidth / 2).smw,
              color: CustomColors.cancel,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIcons.cancel_icon__medium,
                  CustomText(LocaleKeys.Components_ok_cancel_prompt_cancel.tr(),
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
              width: (AppConstants.designWidth / 2).smw,
              color: CustomColors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIcons.check_icon,
                  CustomText(LocaleKeys.Components_ok_cancel_prompt_ok.tr(),
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
