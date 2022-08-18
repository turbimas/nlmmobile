import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class UserRatingsView extends ConsumerStatefulWidget {
  const UserRatingsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserRatingsViewState();
}

class _UserRatingsViewState extends ConsumerState<UserRatingsView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack("Değerlendirmelerim"),
        body: const Center(
          child: Text("Değerlendirmelerim"),
        ),
      ),
    );
  }
}
