import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
      appBar: CustomAppBar.activeBack("Profilim"),
    ));
  }
}
