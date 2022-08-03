import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/product/widgets/home_bottom_bar.dart';
import 'package:nlmmobile/view/main/main_viewmodel.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  final ChangeNotifierProvider<MainViewModel> provider =
      ChangeNotifierProvider<MainViewModel>((ref) => MainViewModel());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: CustomThemeData
                              .scaffoldBackgroundGradinetColors)))),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: ref.watch(provider).activePage(context) ??
                const CircularProgressIndicator(color: Colors.green),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: HomeBottomBar(),
          ),
        ],
      ),
    );
  }
}
