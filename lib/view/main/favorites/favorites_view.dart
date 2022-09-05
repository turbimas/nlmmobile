import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_searchbar_view.dart';

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
        appBar:
            CustomAppBar.inactiveBack(LocaleKeys.Favorites_appbar_title.tr()),
        body: Padding(
          padding: EdgeInsets.only(
              left: 15.smw, right: 15.smw, top: 10.smh, bottom: 75.smh),
          child: Column(
            children: [
              CustomSearchBarView(hint: LocaleKeys.Favorites_search_hint.tr()),
              SizedBox(height: 15.smh),
              const Text("Yapılıyor")
            ],
          ),
        ));
  }
}
