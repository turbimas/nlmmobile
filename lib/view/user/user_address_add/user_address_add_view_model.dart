import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserAddressAddViewModel extends ChangeNotifier {
  UserAddressAddViewModel();

  String address = "Orta, Vezirköprü Cd. 15/B, 34880 Kartal/İstanbul, Turkey";
  Map<String, bool> hintMap = {};
  void setToHintMap(String key, bool value) {
    hintMap[key] = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> setLocations() async {
    if ((await Geolocator.checkPermission()) == LocationPermission.denied) {
      Geolocator.requestPermission();
    }

    Geolocator.getCurrentPosition().then((value) {
      log(value.latitude.toString());
      log(value.longitude.toString());
    });
  }
}
