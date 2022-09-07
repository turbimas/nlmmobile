import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/models/user/user_rating_model.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/product/widgets/product_overview_view.dart';
import 'package:nlmmobile/view/user/user_ratings/user_ratings_view_model.dart';

class UserRatingsView extends ConsumerStatefulWidget {
  const UserRatingsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserRatingsViewState();
}

class _UserRatingsViewState extends ConsumerState<UserRatingsView> {
  late final ChangeNotifierProvider<UserRatingsViewModel> provider;
  @override
  void initState() {
    provider = ChangeNotifierProvider<UserRatingsViewModel>(
        ((ref) => UserRatingsViewModel()));
    Future.delayed(Duration.zero, () {
      ref.read(provider).getRated();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:
            CustomAppBar.activeBack(LocaleKeys.UserRatings_appbar_title.tr()),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [_filters(), _cards()],
        ),
      ),
    );
  }

  Widget _filters() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.smh),
      height: 60.smh,
      width: 360.smw,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: CustomColors.primary, width: 1),
          bottom: BorderSide(color: CustomColors.primary, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => ref.read(provider).index = 0,
              child: AnimatedContainer(
                duration: CustomThemeData.animationDurationShort,
                curve: Curves.easeInOut,
                color: ref.watch(provider).index == 0
                    ? CustomColors.primary
                    : CustomColors.card,
                child: Center(
                  child: CustomTextLocale(LocaleKeys.UserQuestions_answered,
                      style: CustomFonts.bigButton(
                          ref.watch(provider).index == 0
                              ? CustomColors.primaryText
                              : CustomColors.cardText)),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => ref.read(provider).index = 1,
              child: AnimatedContainer(
                duration: CustomThemeData.animationDurationShort,
                curve: Curves.easeInOut,
                color: ref.watch(provider).index == 1
                    ? CustomColors.primary
                    : CustomColors.card,
                child: Center(
                  child: CustomTextLocale(LocaleKeys.UserQuestions_unanswered,
                      style: CustomFonts.bigButton(
                          ref.watch(provider).index == 1
                              ? CustomColors.primaryText
                              : CustomColors.cardText)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cards() {
    return SizedBox(
      height: 670.smh,
      width: 340.smw,
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: ref.watch(provider).index == 0
            ? ref.watch(provider).rated.length
            : ref.watch(provider).unrated.length,
        itemBuilder: (context, index) => ref.watch(provider).index == 0
            ? _ratedCard(index)
            : _unratedCard(index),
      ),
    );
  }

  Widget _ratedCard(index) {
    UserRatingModel rating = ref.watch(provider).rated[index];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
      margin: EdgeInsets.only(bottom: 10.smh),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primary, width: 1.smw),
          borderRadius: CustomThemeData.fullRounded,
          color: CustomColors.card),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductOverViewHorizontal(product: rating.product),
          SizedBox(height: 15.smh),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                AuthService.userImage(height: 25.smh, width: 25.smh),
                SizedBox(width: 10.smw),
                CustomText(AuthService.currentUser!.nameSurname,
                    style: CustomFonts.bodyText3(CustomColors.cardText))
              ]),
              RatingBarIndicator(
                rating: rating.ratingValue.toDouble(),
                itemBuilder: (context, index) =>
                    rating.ratingValue.toDouble() <= index
                        ? CustomIcons.start_unselected
                        : CustomIcons.star_selected,
                itemCount: 5,
                itemSize: 20.smh,
                direction: Axis.horizontal,
              )
            ],
          ),
          SizedBox(height: 5.smh),
          rating.contentValue != null
              ? CustomText(
                  rating.contentValue!,
                  style: CustomFonts.bodyText4(CustomColors.cardText),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _unratedCard(index) {
    // ProductModel product = ref.watch(provider).unrated[index];
    return Container(
      child: const Text("Yapılacak"),
    );
    // Container(
    //   padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
    //   margin: EdgeInsets.only(bottom: 10.smh),
    //   decoration: BoxDecoration(
    //       border: Border.all(color: CustomColors.primary, width: 1.smw),
    //       borderRadius: CustomThemeData.fullRounded,
    //       color: CustomColors.card),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       ProductOverViewHorizontal(product: product),
    //       SizedBox(height: 15.smh),
    //       Center(
    //         child: InkWell(
    //           onTap: () {
    //             PopupHelper.actionPopups.showRatingPopup(
    //                 productOverViewModel: product,
    //                 submit: (value, comment) {
    //                   log("value: $value, comment: $comment");
    //                 });
    //           },
    //           child: Container(
    //             padding:
    //                 EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
    //             decoration: BoxDecoration(
    //                 border:
    //                     Border.all(color: CustomColors.primary, width: 1.smw),
    //                 borderRadius: CustomThemeData.fullRounded,
    //                 color: CustomColors.card),
    //             child: CustomText(LocaleKeys.UserRatings_rate_now,
    //                 style: CustomFonts.bodyText3(CustomColors.cardText)),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
