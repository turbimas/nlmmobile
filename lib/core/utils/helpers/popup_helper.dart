import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/models/product_over_view_model.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/product/widgets/product_overview_view.dart';

class PopupHelper {
  static BuildContext get _context => NavigationService.context;

  static final ActionPopups _actionPopups = ActionPopups();
  static ActionPopups get actionPopups => _actionPopups;

  static Future<void> showError(
      {required String errorMessage,
      bool dismissible = true,
      Object? error,
      List<Map<String, dynamic>> actions = const []}) async {
    showDialog(
        context: _context,
        barrierDismissible: dismissible,
        builder: (context) => AlertDialog(
              backgroundColor: CustomColors.cancel,
              title: Text(
                errorMessage.tr(),
                style: CustomFonts.bodyText3(CustomColors.cancelText),
              ),
              content: error != null
                  ? Text(error.toString(),
                      style: CustomFonts.bodyText4(CustomColors.cancelText))
                  : null,
              actions: actions
                  .map((e) => TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: CustomColors.cancelText,
                      ),
                      onPressed: e['onPressed'] as Function(),
                      child: CustomText(e['text'] as String)))
                  .toList(),
            ));
  }

  static Future<void> showErrorWithCode(Object e) async {
    showError(errorMessage: LocaleKeys.ErrorCodes_ERROR, error: e);
  }

  static Future<void> showSucces(String message) async {
    showDialog(
        context: _context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              backgroundColor: CustomColors.approve,
              title: Text(
                message.tr(),
                style: CustomFonts.bodyText3(CustomColors.cancelText),
              ),
            ));
  }
}

class ActionPopups {
  Future showRatingPopup(
      {required ProductOverViewModel productOverViewModel,
      required Function(int value, String comment) submit}) async {
    showDialog(
      context: PopupHelper._context,
      builder: (context) => RatingDialog(
        productOverViewModel: productOverViewModel,
        submit: submit,
      ),
    );
  }

  Future showQuestionPopup(
      {required ProductOverViewModel productOverViewModel,
      required Function(String) onSubmit}) async {
    showDialog(
      context: PopupHelper._context,
      builder: (context) => QuestionDialog(
          onSubmit: onSubmit, productOverViewModel: productOverViewModel),
    );
  }
}

class RatingDialog extends StatefulWidget {
  final ProductOverViewModel productOverViewModel;
  final Function(int value, String comment) submit;
  const RatingDialog(
      {Key? key, required this.productOverViewModel, required this.submit})
      : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 1;

  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
        height: 450.smh,
        width: 340.smw,
        decoration: BoxDecoration(
            color: CustomColors.primary,
            borderRadius: CustomThemeData.fullRounded),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      NavigationService.back();
                    },
                    child: CustomIcons.cancel_icon__medium)),
            SizedBox(height: 5.smh),
            ProductOverViewHorizontalView(product: widget.productOverViewModel),
            SizedBox(
              height: 120,
              width: 320.smw,
              child: Center(
                  child: RatingBar(
                itemPadding: EdgeInsets.symmetric(horizontal: 5.smw),
                initialRating: 1,
                minRating: 1,
                onRatingUpdate: (value) {
                  _rating = value.toInt();
                },
                ratingWidget: RatingWidget(
                    full: CustomIcons.star_selected,
                    half: CustomIcons.star_selected,
                    empty: CustomIcons.star_white),
              )),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.smw),
                margin: EdgeInsets.only(bottom: 15.smh),
                height: 90.smh,
                width: 320.smw,
                decoration: BoxDecoration(
                    color: CustomColors.cardInner,
                    borderRadius: CustomThemeData.fullRounded),
                child: TextField(
                  controller: _controller,
                  maxLines: 20,
                  style: CustomFonts.bodyText4(CustomColors.cardInnerText),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // TODO: Add localization
                      hintText: "Değerlendirme metni (isteğe bağlı)",
                      hintStyle: CustomFonts.bodyText4(
                          CustomColors.cardInnerTextPale)),
                )),
            InkWell(
              onTap: () => widget.submit(_rating, _controller.text),
              child: Container(
                  width: 255.smw,
                  height: 75.smh,
                  decoration: BoxDecoration(
                      color: CustomColors.secondary,
                      borderRadius: CustomThemeData.fullRounded),
                  child: Center(
                    child: CustomText("Değerlendirmeyi Gönder",
                        style:
                            CustomFonts.bodyText3(CustomColors.secondaryText)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class QuestionDialog extends StatefulWidget {
  final ProductOverViewModel productOverViewModel;
  final Function(String) onSubmit;
  const QuestionDialog(
      {Key? key, required this.onSubmit, required this.productOverViewModel})
      : super(key: key);

  @override
  State<QuestionDialog> createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
        height: 450.smh,
        width: 340.smw,
        decoration: BoxDecoration(
            color: CustomColors.primary,
            borderRadius: CustomThemeData.fullRounded),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      NavigationService.back();
                    },
                    child: CustomIcons.cancel_icon__medium)),
            SizedBox(height: 15.smh),
            ProductOverViewHorizontalView(product: widget.productOverViewModel),
            SizedBox(height: 20.smh),
            SizedBox(
                height: 25.smh,
                width: 320.smw,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      "Soru metni girin",
                      style: CustomFonts.bodyText4(CustomColors.primaryText),
                    ))),
            SizedBox(height: 15.smh),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.smh, vertical: 0.smh),
              height: 150.smh,
              width: 320.smw,
              decoration: BoxDecoration(
                  borderRadius: CustomThemeData.fullRounded,
                  color: CustomColors.cardInner),
              child: TextField(
                maxLines: 20,
                controller: _controller,
                style: CustomFonts.bodyText4(CustomColors.cardInnerText),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Soru metni girin",
                    hintStyle:
                        CustomFonts.bodyText4(CustomColors.cardInnerTextPale)),
              ),
            ),
            SizedBox(height: 15.smh),
            InkWell(
              onTap: () {
                widget.onSubmit(_controller.text);
                NavigationService.back();
              },
              child: Container(
                height: 70.smh,
                width: 270.smw,
                decoration: BoxDecoration(
                    borderRadius: CustomThemeData.fullRounded,
                    color: CustomColors.secondary),
                child: Center(
                  child: CustomText("Sor",
                      style: CustomFonts.bigButton(CustomColors.secondaryText)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
