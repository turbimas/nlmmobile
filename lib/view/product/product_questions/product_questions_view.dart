import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/product/models/product_detail_model.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class ProductQuestionsView extends ConsumerStatefulWidget {
  final ProductDetailModel product;
  const ProductQuestionsView({Key? key, required this.product})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductQuestionsViewState();
}

class _ProductQuestionsViewState extends ConsumerState<ProductQuestionsView> {
  @override
  Widget build(BuildContext context) {
    return const CustomSafeArea(
      child: Scaffold(),
    );
  }
}
