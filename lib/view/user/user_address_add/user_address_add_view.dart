import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/product/widgets/ok_cancel_prompt.dart';
import 'package:nlmmobile/view/user/user_address_add/user_address_add_view_model.dart';

class UserAddressAddView extends ConsumerStatefulWidget {
  const UserAddressAddView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserAddressAddViewState();
}

class _UserAddressAddViewState extends ConsumerState<UserAddressAddView> {
  late final ChangeNotifierProvider<UserAddressAddViewModel> provider;

  final TextEditingController _addressHeaderController =
      TextEditingController();
  final TextEditingController _nameSurnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _taxNoController = TextEditingController();
  final TextEditingController _taxOfficeController = TextEditingController();

  @override
  void initState() {
    provider = ChangeNotifierProvider((ref) => UserAddressAddViewModel());
    ref.read(provider).setLocations();
    super.initState();
  }

  @override
  void dispose() {
    _addressHeaderController.dispose();
    _nameSurnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    _taxNoController.dispose();
    _taxOfficeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack("Adres ekle"),
        body: _content(),
      ),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            SizedBox(
              height: AppConstants.designWidth.smw,
              width: AppConstants.designWidth.smw,
              child: const GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(41.015137, 28.979530),
                  zoom: 14.4746,
                ),
              ),
            ),
            _addressSummary(),
            _customTextField(
                hint: "Adres başlığı", controller: _addressHeaderController),
            _customTextField(
                controller: _nameSurnameController, hint: "İsim soyisim"),
            _customTextField(hint: "Email", controller: _emailController),
            _customTextField(hint: "Telefon", controller: _phoneController),
            _customTextField(
                hint: "Not", controller: _noteController, lines: 3),
            _customTextField(
                hint: "Vergi numarası", controller: _taxNoController),
            _customTextField(
                hint: "Vergi dairesi", controller: _taxOfficeController),
            OkCancelPrompt(okCallBack: () {}, cancelCallBack: () {})
          ],
        ),
      ),
    );
  }

  Widget _addressSummary() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.smw, vertical: 10.smh),
      child: Center(
          child: CustomText(
        ref.watch(provider).address,
        maxLines: 3,
      )),
    );
  }

  Widget _customTextField({
    required String hint,
    int lines = 1,
    required TextEditingController controller,
  }) {
    return Container(
      width: 330.smw,
      padding: EdgeInsets.symmetric(horizontal: 10.smw),
      margin: EdgeInsets.symmetric(vertical: 5.smh),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.smh),
          color: CustomColors.primary),
      child: Center(
        child: TextFormField(
          maxLines: lines,
          onTap: () {
            if (controller.text.isNotEmpty) {
              ref.read(provider).setToHintMap(hint, true);
            }
          },
          onEditingComplete: () {
            ref.read(provider).setToHintMap(hint, false);
          },

          // textAlignVertical: TextAlignVertical.center,
          controller: controller,
          onChanged: (value) {
            if (value.isNotEmpty) {
              ref.read(provider).setToHintMap(hint, true);
            } else {
              ref.read(provider).setToHintMap(hint, false);
            }
          },
          style: CustomFonts.defaultField(CustomColors.primaryText),
          decoration: InputDecoration(
              suffixIcon: ref.watch(provider).hintMap[hint] == true
                  ? IconButton(
                      onPressed: () {
                        controller.text = "";
                        ref.read(provider).setToHintMap(hint, false);
                      },
                      icon: Icon(Icons.clear, color: CustomColors.primaryText))
                  : null,
              hintText: hint,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintStyle: CustomFonts.defaultField(CustomColors.primaryText)),
        ),
      ),
    );
  }
}
