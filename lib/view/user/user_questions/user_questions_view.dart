import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class UserQuestionsView extends ConsumerStatefulWidget {
  const UserQuestionsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserQuestionsViewState();
}

class _UserQuestionsViewState extends ConsumerState<UserQuestionsView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(appBar: CustomAppBar.activeBack("Sorularım")),
    );
  }
}
