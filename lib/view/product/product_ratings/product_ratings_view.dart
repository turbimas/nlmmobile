import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/product/models/product_detail_model.dart';
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
    return const CustomSafeArea(
      child: Scaffold(),
    );
  }
}
