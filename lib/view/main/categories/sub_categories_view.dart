import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/models/category_model.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/ok_cancel_prompt.dart';

class SubCategoriesView extends ConsumerStatefulWidget {
  CategoryModel masterCategory;
  SubCategoriesView({Key? key, required this.masterCategory}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubCategoriesViewState();
}

class _SubCategoriesViewState extends ConsumerState<SubCategoriesView> {
  @override
  void initState() {
    log(widget.masterCategory.subCategories.length.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
            appBar: CustomAppBar.activeBack("Tüm Kategoriler"),
            body: Stack(
              children: [
                Positioned(
                    top: 0,
                    child: Column(children: [
                      _mainCategories(),
                    ])),
                Positioned(
                    bottom: 0,
                    child: OkCancelPrompt(
                      cancelCallBack: () {},
                      okCallBack: () {},
                    )),
              ],
            )));
  }

  Widget _mainCategories() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.smw),
        height: ((((widget.masterCategory.subCategories.length - 1) ~/ 5) + 1) *
                100)
            .smh,
        width: AppConstants.designWidth.smw,
        color: Colors.grey,
        child: GridView.custom(
            childrenDelegate: SliverChildListDelegate(List.generate(
                widget.masterCategory.subCategories.length,
                (index) => Container(
                    color: Colors.red,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.smh),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network("https://picsum.photos/250",
                                width: 60.smw, height: 60.smh),
                          ),
                          SizedBox(
                              height: 35.smh,
                              child: Text(
                                  "Kategori adı\n: ${widget.masterCategory.subCategories[index]}"))
                        ])))),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisExtent: 100.smh,
                crossAxisSpacing: 10.smw)));
  }
}
