import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';

class OkCancelPrompt extends StatelessWidget {
  final Function okCallBack;
  final Function cancelCallBack;
  const OkCancelPrompt(
      {Key? key, required this.okCallBack, required this.cancelCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.designWidth.smw,
      height: 50.smh,
      child: Row(
        children: [
          Container(
            height: 50.smh,
            width: (AppConstants.designWidth / 2).smw,
            color: CustomThemeData.cancelColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.cancel, color: Colors.white),
                Text("İptal",
                    style: GoogleFonts.inder(
                        color: Colors.white, fontSize: 20.sp)),
              ],
            ),
          ),
          Container(
            height: 50.smh,
            width: (AppConstants.designWidth / 2).smw,
            color: CustomThemeData.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.check, color: Colors.white),
                Text("Onayla",
                    style: GoogleFonts.inder(
                        color: Colors.white, fontSize: 20.sp)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
