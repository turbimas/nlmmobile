import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/searchbar/searchbar_view.dart';
import 'package:nlmmobile/view/main/subpages/search/search_viewmodel.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchbarState();
}

class SearchbarState extends ConsumerState<SearchView> {
  late ScrollController _scrollController;
  bool isVisible = true;

  late ChangeNotifierProvider<SearchViewModel> provider;

  @override
  void initState() {
    _scrollController = ScrollController();
    provider = ChangeNotifierProvider<SearchViewModel>((ref) =>
        SearchViewModel(categoriesScrollController: _scrollController));

    super.initState();
  }

  @override
  void dispose() {
    // ref.read(provider).dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafearea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 75.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SearchBarView(hint: "Ürün veya kategori ara"),
              SizedBox(height: ref.watch(provider).sizedBoxHeight.h),
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30.w,
                    mainAxisSpacing: 20.h,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network("https://picsum.photos/200/300",
                          fit: BoxFit.cover, height: 150.h, width: 150.w),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
