import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/models/product_over_view_model.dart';
import 'package:nlmmobile/product/widgets/product_overview_view.dart';

class PopupHelper {
  static BuildContext get _context => NavigationService.context;

  static final ActionPopups _actionPopups = ActionPopups();
  static ActionPopups get actionPopups => _actionPopups;

  static Future<void> showError(
      {required String message,
      bool dismissible = true,
      List<Map<String, dynamic>> actions = const []}) async {
    showDialog(
        context: _context,
        barrierDismissible: dismissible,
        builder: (context) => AlertDialog(
              backgroundColor: CustomColors.cancel,
              title: Text(
                message,
                style: CustomFonts.bodyText3(CustomColors.cancelText),
              ),
              actions: actions
                  .map((e) => TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: CustomColors.cancelText,
                      ),
                      onPressed: e['onPressed'] as Function(),
                      child: Text(e['text'] as String)))
                  .toList(),
            ));
  }
}

class ActionPopups {
  static double _rating = 0;
  static Dialog? dialog;

  Future showRatingPopup(
      {required ProductOverViewModel productOverViewModel,
      required Function(double value, String comment)? submit}) async {
    TextEditingController controller = TextEditingController();

    _rating = 0;
    dialog = Dialog(
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
            ProductOverViewHorizontal(product: productOverViewModel),
            SizedBox(
              height: 120,
              width: 320.smw,
              child: Center(
                  child: RatingBar(
                itemPadding: EdgeInsets.symmetric(horizontal: 5.smw),
                initialRating: 1,
                minRating: 1,
                onRatingUpdate: (value) {
                  _rating = value;
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
                  controller: controller,
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
              onTap: () => submit!(_rating, controller.text),
              child: Container(
                  width: 255.smw,
                  height: 75.smh,
                  decoration: BoxDecoration(
                      color: CustomColors.secondary,
                      borderRadius: CustomThemeData.fullRounded),
                  child: Center(
                    child: Text("Değerlendirmeyi Gönder",
                        style:
                            CustomFonts.bodyText3(CustomColors.secondaryText)),
                  )),
            )
          ],
        ),
      ),
    );
    showDialog(
      context: PopupHelper._context,
      builder: (context) => dialog!,
    ).then((value) {
      controller.dispose();
    });
  }
}
