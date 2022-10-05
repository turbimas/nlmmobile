import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> invoiceFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    provider = ChangeNotifierProvider((ref) => UserAddressAddViewModel());
    ref.read(provider).goCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    ref.watch(provider).countryController.dispose();
    ref.watch(provider).cityController.dispose();
    ref.watch(provider).regionController.dispose();
    ref.watch(provider).districtController.dispose();
    ref.watch(provider).townController.dispose();
    ref.watch(provider).streetController.dispose();
    ref.watch(provider).buildingController.dispose();
    ref.watch(provider).postalCodeController.dispose();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: CustomThemeData.animationDurationMedium,
          height: ref.watch(provider).isExpanded ? 750.smh : 0,
          width: AppConstants.designWidth.smw,
          child: Stack(
            children: [
              Positioned.fill(
                  child: GoogleMap(
                compassEnabled: true,
                mapToolbarEnabled: true,
                myLocationEnabled: false,
                trafficEnabled: false,
                onCameraMove: (position) {
                  ref.read(provider).marker = Marker(
                    markerId: const MarkerId("marker"),
                    position: position.target,
                  );
                  if (ref.watch(provider).isExpanded == false) {
                    ref.read(provider).isExpanded = true;
                  }
                },
                onMapCreated: (controller) async {
                  ref.read(provider).mapController = controller;
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      const CameraPosition(
                        target: LatLng(40, 40),
                        zoom: 15,
                      ),
                    ),
                  );
                },
                markers: {ref.watch(provider).marker},
                initialCameraPosition: const CameraPosition(
                  target: LatLng(41.015137, 28.979530),
                  zoom: 14.4746,
                ),
              )),
              Positioned(
                left: 80.smw,
                bottom: 10.smh,
                child: ref.watch(provider).isExpanded
                    ? InkWell(
                        onTap: ref.read(provider).getLocationData,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: CustomThemeData.fullRounded,
                                color: CustomColors.primary),
                            height: 50.smh,
                            width: 200.smw,
                            child: Center(
                              child: CustomText("Bu konumu kullan",
                                  style: CustomFonts.bodyText2(
                                      CustomColors.primaryText)),
                            )),
                      )
                    : Container(),
              ),
              Positioned(
                top: 10.smh,
                right: 10.smw,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: CustomThemeData.fullRounded,
                      color: Colors.white),
                  padding: const EdgeInsets.all(2),
                  child: IconButton(
                    icon: const Icon(Icons.location_on_outlined),
                    onPressed: ref.read(provider).goCurrentLocation,
                  ),
                ),
              )
            ],
          ),
        ),
        AnimatedContainer(
          margin: ref.watch(provider).isExpanded
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(vertical: 10.smh),
          duration: CustomThemeData.animationDurationMedium,
          height: ref.watch(provider).isExpanded ? 0 : 50.smh,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () {
                    ref.read(provider).isExpanded = true;
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.smw),
                    decoration: BoxDecoration(
                        borderRadius: CustomThemeData.fullRounded,
                        color: CustomColors.primary),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText("Haritayı aç",
                              style: CustomFonts.bodyText2(
                                  CustomColors.primaryText)),
                          SizedBox(width: 10.smw),
                          Icon(Icons.map, color: CustomColors.primaryText)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    ref.read(provider).isExpanded = true;
                    ref.read(provider).goCurrentLocation();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.smw),
                    decoration: BoxDecoration(
                        borderRadius: CustomThemeData.fullRounded,
                        color: CustomColors.primary),
                    child: Center(
                        child: Icon(Icons.location_on_outlined,
                            color: CustomColors.primaryText)),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: CustomColors.secondary,
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _addressSummary(),
                      _customTextField(
                          label: "Ülke",
                          formKey: "Country",
                          controller: ref.read(provider).countryController),
                      _customTextField(
                          label: "Şehir",
                          formKey: "City",
                          controller: ref.read(provider).cityController),
                      _customTextField(
                          label: "Bölge",
                          formKey: "Region",
                          controller: ref.read(provider).regionController),
                      _customTextField(
                          label: "Semt",
                          formKey: "District",
                          controller: ref.read(provider).districtController),
                      _customTextField(
                          label: "Mahalle",
                          formKey: "Town",
                          controller: ref.read(provider).townController),
                      _customTextField(
                          label: "Sokak",
                          formKey: "Street",
                          controller: ref.read(provider).streetController),
                      _customTextField(
                          label: "Bina no",
                          formKey: "BuildingNo",
                          controller: ref.read(provider).buildingController),
                      _customTextField(
                          label: "Posta kodu",
                          formKey: "PostalCode",
                          keyboardType: TextInputType.number,
                          controller: ref.read(provider).postalCodeController),
                      _customTextField(
                          label: "Adres başlığı", formKey: "AdresBasligi"),
                      _customTextField(
                          label: "İsim soyisim",
                          formKey: "RelatedPerson",
                          initialValue: AuthService.currentUser!.nameSurname),
                      _customTextField(
                          label: "Email",
                          formKey: "Email",
                          initialValue: AuthService.currentUser!.email,
                          keyboardType: TextInputType.emailAddress),
                      _customTextField(
                          label: "Telefon",
                          formKey: "MobilePhone",
                          initialValue: AuthService.currentUser!.phone,
                          keyboardType: TextInputType.phone),
                      _customTextField(
                          label: "Not", formKey: "Notes", lines: 3),
                      CheckboxListTile(
                          title: CustomText("Fatura bilgisi ekle",
                              style: CustomFonts.bodyText2(
                                  CustomColors.primaryText)),
                          value: ref.watch(provider).isInvoice,
                          activeColor: CustomColors.primary,
                          checkColor: CustomColors.primaryText,
                          onChanged: (value) {
                            ref.read(provider).isInvoice = value!;
                          }),
                      ref.watch(provider).isInvoice
                          ? _invoiceInfo()
                          : Container(),
                      OkCancelPrompt(okCallBack: () {
                        formKey.currentState!.save();
                        if (ref.watch(provider).isInvoice) {
                          invoiceFormKey.currentState!.save();
                        }
                        ref.read(provider).addAddress();
                      }, cancelCallBack: () {
                        NavigationService.back();
                      })
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget _addressSummary() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.smw, vertical: 10.smh),
      child: Center(
          child: CustomText(
        ref.watch(provider).googleAddressModel != null
            ? ref.watch(provider).googleAddressModel!.formatAddress
            : "Adres bilgisi alınıyor...",
        style: CustomFonts.bodyText2(CustomColors.secondaryText),
        maxLines: 3,
      )),
    );
  }

  Widget _customTextField(
      {String? label,
      int lines = 1,
      required String formKey,
      String? initialValue,
      TextInputType keyboardType = TextInputType.text,
      TextEditingController? controller}) {
    return Container(
      width: 330.smw,
      padding: EdgeInsets.symmetric(horizontal: 10.smw),
      margin: EdgeInsets.symmetric(vertical: 5.smh),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.smh),
          color: CustomColors.primary),
      child: Center(
        child: TextFormField(
          initialValue: initialValue,
          keyboardType: keyboardType,
          controller: controller,
          onSaved: (value) {
            if (value == null) return;
            if (controller != null) return;
            if (value.isNotEmpty) {
              ref.read(provider).formData[formKey] = value;
            }
          },
          maxLines: lines,
          style: CustomFonts.defaultField(CustomColors.primaryText),
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            labelStyle: CustomFonts.bodyText2(CustomColors.primaryText),
            floatingLabelStyle: CustomFonts.bodyText2(CustomColors.primaryText),
          ),
        ),
      ),
    );
  }

  Widget _invoiceInfo() {
    return Form(
      key: invoiceFormKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () => ref.read(provider).isPersonal = true,
                  child: Row(children: [
                    ref.watch(provider).isPersonal
                        ? CustomIcons.radio_checked_dark_icon
                        : CustomIcons.radio_unchecked_dark_icon,
                    SizedBox(width: 15.smw),
                    CustomText("Şahıs",
                        style: CustomFonts.bodyText2(CustomColors.primaryText))
                  ])),
              InkWell(
                  onTap: () {
                    ref.read(provider).isPersonal = false;
                  },
                  child: Row(children: [
                    !ref.watch(provider).isPersonal
                        ? CustomIcons.radio_checked_dark_icon
                        : CustomIcons.radio_unchecked_dark_icon,
                    SizedBox(width: 15.smw),
                    CustomText("Kurumsal",
                        style: CustomFonts.bodyText2(CustomColors.primaryText))
                  ])),
            ],
          ),
          ..._invoiceInformations()
        ],
      ),
    );
  }

  List<Widget> _invoiceInformations() {
    if (ref.watch(provider).isPersonal) {
      return _personalInvoice();
    } else {
      return _companyInvoice();
    }
  }

  List<Widget> _personalInvoice() {
    return [
      _customTextField(label: "TC No", formKey: "TCKNo"),
    ];
  }

  List<Widget> _companyInvoice() {
    return [
      _customTextField(label: "Vergi numarası", formKey: "TaxNumber"),
      _customTextField(label: "Vergi dairesi", formKey: "TaxOffice"),
    ];
  }
}
