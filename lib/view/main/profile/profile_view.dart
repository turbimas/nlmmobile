import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/constants/navigation_constants.dart';
import 'package:nlmmobile/product/cubits/home_index_cubit/home_index_cubit.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.inactiveBack("Profilim"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.smh),
            _notificationRow(),
            _profilePhoto(),
            _greeting(),
            _option("Siparişlerim", NavigationConstants.userOrders),
            _option("Kuponlarım", NavigationConstants.userPromotions),
            _option("Adreslerim", NavigationConstants.userAddresses),
            _option("Kartlarım", NavigationConstants.userCards),
            _option("Değerlendirmelerim", NavigationConstants.userRatings),
            _option("Sorularım", NavigationConstants.userQuestions),
            InkWell(
                onTap: _logout,
                child: _option("Çıkış yap", NavigationConstants.login,
                    noBack: true)),
            SizedBox(height: 75.smh),
          ],
        ),
      ),
    );
  }

  void _logout() {
    context.read<HomeIndexCubit>().set(2);
    AuthService.logout();
  }

  Widget _greeting() {
    return SizedBox(
      height: 80.smh,
      width: AppConstants.designWidth.smw,
      child: Center(
          child: Text("Merhaba\nErtuğrul Çakıcı",
              style: GoogleFonts.leagueSpartan(fontSize: 20.sp),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip)),
    );
  }

  Widget _notificationRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.smw),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 80.smw,
          height: 30.smh,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomThemeData.secondaryColor),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text("22",
                style: GoogleFonts.leagueSpartan(
                    fontSize: 16.sp, color: Colors.white)),
            const Icon(Icons.notifications_active, color: Colors.white),
          ]),
        ),
      ),
    );
  }

  Widget _option(String title, String path, {bool noBack = false}) {
    return InkWell(
      onTap: () {
        if (noBack) {
          NavigationService.navigateToNameAndRemoveUntil(path);
        } else {
          NavigationService.navigateToName(path);
        }
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 10.smh),
          height: 60.smh,
          width: 330.smw,
          decoration: BoxDecoration(
              color: CustomThemeData.profileCardColor,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.only(left: 20.smw),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: GoogleFonts.leagueSpartan(fontSize: 20.sp),
              ),
            ),
          )),
    );
  }

  Widget _profilePhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(220.smh),
      child: Image.network(
        "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
        fit: BoxFit.cover,
        height: 220.smh,
        width: 220.smh,
      ),
    );
  }
}
