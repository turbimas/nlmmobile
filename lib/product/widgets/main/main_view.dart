import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
import 'package:nlmmobile/product/widgets/bottom_bar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/main/main_view_model.dart';
=======
import 'package:koyevi/product/widgets/bottom_bar.dart';
import 'package:koyevi/product/widgets/custom_safearea.dart';
import 'package:koyevi/product/widgets/main/main_view_model.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

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
    return CustomSafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: ref.watch(provider).activePage(context) ??
                  const CircularProgressIndicator(color: Colors.green),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomBar(),
            ),
          ],
        ),
      ),
    );
  }
}
