import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';

class SearchBarView extends ConsumerStatefulWidget {
  final String hint;
  const SearchBarView({Key? key, required this.hint}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarViewState();
}

class _SearchBarViewState extends ConsumerState<SearchBarView> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(color: CustomThemeData.searchBarTextColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        prefixIcon: const Icon(
          Icons.search,
          color: CustomThemeData.searchBarIconColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        hintText: widget.hint,
        fillColor: CustomThemeData.searchBarBackgroundColor,
        iconColor: CustomThemeData.searchBarIconColor,
        hintStyle: GoogleFonts.inder(
          fontSize: 12.sp,
          color: CustomThemeData.searchBarTextColor,
        ),
      ),
    );
  }
}
