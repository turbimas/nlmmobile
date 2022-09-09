import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/product/models/product_detail_model.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class ProductRatingsView extends ConsumerStatefulWidget {
  final ProductDetailModel product;
  const ProductRatingsView({Key? key, required this.product}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ProductRatingsViewState();
}

class ProductRatingsViewState extends ConsumerState<ProductRatingsView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack(
            LocaleKeys.ProductRatings_appbar_title.tr()),
      ),
    );
  }
}
