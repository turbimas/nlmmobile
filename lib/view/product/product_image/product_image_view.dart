import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/product/models/product_detail_model.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class ProductImagesView extends StatefulWidget {
  final ProductDetailModel productDetailModel;
  const ProductImagesView({super.key, required this.productDetailModel});

  @override
  State<ProductImagesView> createState() => _ProductImagesViewState();
}

class _ProductImagesViewState extends State<ProductImagesView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack(LocaleKeys.ProductImage_appbar_title.tr(
            args: [widget.productDetailModel.name])),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [],
        ),
      ),
    );
  }
}
