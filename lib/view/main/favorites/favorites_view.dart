import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/product_overview/product_overview_view.dart';
import 'package:nlmmobile/product/widgets/searchbar/searchbar_view.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.inactiveBack("Favori ürünlerim"),
        body: Padding(
          padding: EdgeInsets.only(
              left: 15.smw, right: 15.smw, top: 10.smh, bottom: 75.smh),
          child: Column(
            children: [
              const SearchBarView(hint: "Favorilerde ara"),
              SizedBox(height: 15.smh),
              Expanded(
                child: Scrollbar(
                  trackVisibility: true,
                  radius: const Radius.circular(45),
                  child: GridView.custom(
                    shrinkWrap: true,
                    childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) => const ProductOverviewView(),
                        childCount: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 250.smh,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.smh,
                        crossAxisSpacing: 20.smw),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
