import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_images.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/core/utils/validators/validators.dart';
import 'package:nlmmobile/product/widgets/custom_circular.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/product/widgets/ok_cancel_prompt.dart';
import 'package:nlmmobile/view/auth/validation/validation_view_model.dart';

class ValidationView extends ConsumerStatefulWidget {
  Map<String, dynamic> registerData;
  ValidationView({Key? key, required this.registerData}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ValidationViewState();
}

class _ValidationViewState extends ConsumerState<ValidationView> {
  late ChangeNotifierProvider<ValidationViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider(
        (ref) => ValidationViewModel(widget.registerData));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<bool>(
          future: ref.read(provider).sendMail(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return _form();
              } else {
                return const Center(child: CustomCircularProgressIndicator());
              }
            } else {
              return const Center(child: CustomCircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Column _form() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _image(),
            _message(),
            _field(),
            _resend(),
          ],
        ),
        OkCancelPrompt(
            okCallBack: ref.read(provider).approve,
            cancelCallBack: () {
              NavigationService.back();
            })
      ],
    );
  }

  Container _field() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.smh),
      padding: EdgeInsets.symmetric(horizontal: 30.smw),
      decoration: BoxDecoration(
          color: CustomColors.primary,
          borderRadius: CustomThemeData.fullInfiniteRounded),
      constraints: BoxConstraints(minHeight: 50.smh),
      width: 300.smw,
      child: Form(
        key: ref.watch(provider).formKey,
        child: TextFormField(
          validator: Validators.instance.validationCodeValidator,
          onSaved: (newValue) =>
              ref.read(provider).approvedValidationCode = newValue ?? "",
          keyboardType: TextInputType.number,
          style: CustomFonts.defaultField(CustomColors.primaryText),
          decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: CustomFonts.defaultField(CustomColors.primaryText),
              hintStyle: CustomFonts.defaultField(CustomColors.primaryText),
              hintText: LocaleKeys.Validation_validation_hint.tr()),
        ),
      ),
    );
  }

  SizedBox _message() {
    return SizedBox(
      height: 80.smh,
      width: 300.smw,
      child: Center(
        child: CustomText(
            LocaleKeys.Validation_sent_message.tr(
                args: [widget.registerData["Email"]]),
            style: CustomFonts.bodyText4(CustomColors.backgroundText)),
      ),
    );
  }

  SizedBox _image() {
    return SizedBox(
        height: 310.smh,
        width: 250.smw,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.smh),
            child: Center(child: CustomImages.validation_image)));
  }

  Widget _resend() {
    return Container(
      width: 300.smw,
      constraints: BoxConstraints(
        minHeight: 30.smh,
      ),
      margin: EdgeInsets.symmetric(horizontal: 30.smw),
      child: InkWell(
        onTap: !ref.watch(provider).resented ? ref.read(provider).resend : null,
        child: Align(
            alignment: Alignment.centerRight,
            child: CustomText(ref.watch(provider).resented
                ? LocaleKeys.Validation_resended.tr()
                : LocaleKeys.Validation_resend.tr())),
      ),
    );
  }
}
