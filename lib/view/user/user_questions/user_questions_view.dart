import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/view/user/user_questions/user_questions_view_model.dart';

class UserQuestionsView extends ConsumerStatefulWidget {
  const UserQuestionsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserQuestionsViewState();
}

class _UserQuestionsViewState extends ConsumerState<UserQuestionsView> {
  late final ChangeNotifierProvider<UserQuestionsViewModel> provider;
  @override
  void initState() {
    provider = ChangeNotifierProvider<UserQuestionsViewModel>(
        ((ref) => UserQuestionsViewModel()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack(LocaleKeys.UserQuestions_appbar_title),
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
      decoration: BoxDecoration(
          color: CustomColors.card,
          border: Border.symmetric(
            horizontal: BorderSide(color: CustomColors.primary, width: 1),
          )),
      margin: EdgeInsets.symmetric(vertical: 10.smh),
      height: 60.smh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: InkWell(
            onTap: () => ref.read(provider).index = 0,
            child: Container(
                color: ref.watch(provider).index == 0
                    ? CustomColors.primary
                    : CustomColors.card,
                child: Center(
                    child: Text(LocaleKeys.UserQuestions_answered,
                        style: CustomFonts.bodyText1(
                          ref.watch(provider).index == 0
                              ? CustomColors.primaryText
                              : CustomColors.cardText,
                        )))),
          )),
          Expanded(
              child: InkWell(
            onTap: () => ref.read(provider).index = 1,
            child: Container(
                color: ref.watch(provider).index == 1
                    ? CustomColors.primary
                    : CustomColors.card,
                child: Center(
                    child: Text(LocaleKeys.UserQuestions_unanswered,
                        style: CustomFonts.bodyText1(
                          ref.watch(provider).index == 1
                              ? CustomColors.primaryText
                              : CustomColors.cardText,
                        )))),
          ))
        ],
      ),
    );
  }

  Widget _cards() {
    return SizedBox(
      height: 670.smh,
      width: 340.smw,
      child: const Text("_cards"),
      // child: ListView.builder(
      //   addAutomaticKeepAlives: true,
      //   itemCount: ref.watch(provider).index == 0
      //       ? ref.watch(provider).answered.length
      //       : ref.watch(provider).unanswered.length,
      //   itemBuilder: (context, index) => ref.watch(provider).index == 0
      //       ? _answeredCard(index)
      //       : _unansweredCard(index),
      // ),
    );
  }

  // Widget _answeredCard(index) {
  //   QuestionModel questionModel = ref.watch(provider).answered[index];
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
  //     margin: EdgeInsets.only(bottom: 10.smh),
  //     decoration: BoxDecoration(
  //         border: Border.all(color: CustomColors.primary, width: 1.smw),
  //         borderRadius: CustomThemeData.fullRounded,
  //         color: CustomColors.card),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         ProductOverViewHorizontal(
  //             product: questionModel.productOverViewModel),
  //         SizedBox(height: 15.smh),
  //         Row(children: [
  //           Image.network(questionModel.userImageUrl,
  //                   fit: BoxFit.fill, width: 25.smh, height: 25.smh)
  //               .frd,
  //           SizedBox(width: 10.smw),
  //           Text(questionModel.userName,
  //               style: CustomFonts.bodyText3(CustomColors.cardText))
  //         ]),
  //         SizedBox(height: 5.smh),
  //         Text(
  //           questionModel.question,
  //           style: CustomFonts.bodyText4(CustomColors.cardText),
  //         ),
  //         SizedBox(height: 15.smh),
  //         Row(children: [
  //           CustomIcons.answer_icon,
  //           SizedBox(width: 10.smw),
  //           Text(LocaleKeys.UserQuestions_seller_answer,
  //               style: CustomFonts.bodyText3(CustomColors.cardText))
  //         ]),
  //         SizedBox(height: 5.smh),
  //         Text(
  //           questionModel.answer!,
  //           style: CustomFonts.bodyText4(CustomColors.cardText),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _unansweredCard(index) {
  //   QuestionModel questionModel = ref.watch(provider).unanswered[index];
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
  //     margin: EdgeInsets.only(bottom: 10.smh),
  //     decoration: BoxDecoration(
  //         border: Border.all(color: CustomColors.primary, width: 1.smw),
  //         borderRadius: CustomThemeData.fullRounded,
  //         color: CustomColors.card),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         ProductOverViewHorizontal(
  //             product: questionModel.productOverViewModel),
  //         SizedBox(height: 15.smh),
  //         Row(children: [
  //           Image.network(questionModel.userImageUrl,
  //                   fit: BoxFit.fill, width: 25.smh, height: 25.smh)
  //               .frd,
  //           SizedBox(width: 10.smw),
  //           Text(questionModel.userName,
  //               style: CustomFonts.bodyText3(CustomColors.cardText))
  //         ]),
  //         SizedBox(height: 5.smh),
  //         Text(
  //           questionModel.question,
  //           style: CustomFonts.bodyText4(CustomColors.cardText),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
