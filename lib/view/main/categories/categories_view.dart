import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/navigation_constants.dart';
import 'package:nlmmobile/product/models/category_model.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/searchbar/searchbar_view.dart';
import 'package:nlmmobile/view/main/categories/sub_categories_view.dart';

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CategoriesState();
}

class CategoriesState extends ConsumerState<CategoriesView> {
  List<CategoryModel> categories =
      List.generate(10, (index) => CategoryModel(index.toString()));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.inactiveBack("Ürün kategorileri"),
      body: Padding(
        padding: EdgeInsets.only(
            top: 10.smh, left: 15.smw, right: 15.smw, bottom: 75.smh),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  NavigationService.navigateToName(NavigationConstants.search);
                },
                child: const AbsorbPointer(
                    child: SearchBarView(hint: "Ürün veya kategori ara"))),
            SizedBox(height: 15.smh),
            Expanded(
              child: Scrollbar(
                trackVisibility: true,
                radius: const Radius.circular(45),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30.w,
                    mainAxisSpacing: 20.h,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          NavigationService.navigateToPage(SubCategoriesView(
                              masterCategory: categories[index]));
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                "https://picsum.photos/150/150",
                                fit: BoxFit.cover,
                                height: 150.h,
                                width: 150.w)));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
