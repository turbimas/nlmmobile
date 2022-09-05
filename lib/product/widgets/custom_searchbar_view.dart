import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';

class CustomSearchBarView extends ConsumerStatefulWidget {
  final String hint;
  const CustomSearchBarView({Key? key, required this.hint}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomSearchBarViewState();
}

class _CustomSearchBarViewState extends ConsumerState<CustomSearchBarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.primary,
        borderRadius: CustomThemeData.fullRounded,
      ),
      constraints: BoxConstraints(minHeight: 45.smh, minWidth: 330.smw),
      width: 330.smw,
      height: 45.smh,
      child: Center(
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          style: CustomFonts.defaultField(CustomColors.secondaryText),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            prefixIcon: Icon(
              Icons.search,
              color: CustomColors.secondaryText,
            ),
            border: InputBorder.none,
            hintText: widget.hint,
            iconColor: CustomColors.secondaryText,
            hintStyle: CustomFonts.defaultField(CustomColors.secondaryText),
          ),
        ),
      ),
    );
  }
}
