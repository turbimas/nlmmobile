import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koyevi/core/services/localization/locale_keys.g.dart';
import 'package:koyevi/core/services/theme/custom_colors.dart';
import 'package:koyevi/core/services/theme/custom_fonts.dart';
import 'package:koyevi/core/utils/extensions/ui_extensions.dart';
import 'package:koyevi/product/widgets/custom_appbar.dart';
import 'package:koyevi/product/widgets/custom_safearea.dart';
import 'package:koyevi/view/user/user_promotions/user_promotions_view_model.dart';

class UserPromotionsView extends ConsumerStatefulWidget {
  const UserPromotionsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserPromotionsViewState();
}

class _UserPromotionsViewState extends ConsumerState<UserPromotionsView> {
  late final ChangeNotifierProvider<UserPromotionsViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider((ref) => UserPromotionsViewModel());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack(LocaleKeys.UserPromotions_appbar_title),
        body: ListView.builder(
          itemCount: ref.watch(provider).promotionMessages.length,
          itemBuilder: (context, index) => _promotionCard(index),
        ),
      ),
    );
  }

  _promotionCard(index) {
    String promotionMessage = ref.watch(provider).promotionMessages[index];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.smw, vertical: 10.smh),
      padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
      width: 320.smw,
      decoration: BoxDecoration(
        color: CustomColors.card,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(promotionMessage,
          style: CustomFonts.bodyText4(CustomColors.cardText)),
    );
  }
}
