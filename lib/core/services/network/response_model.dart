import 'package:easy_localization/easy_localization.dart';

typedef ResponseModelMap = ResponseModel<Map<dynamic, dynamic>>;
typedef ResponseModelList = ResponseModel<List<dynamic>>;
typedef ResponseModelString = ResponseModel<String>;
typedef ResponseModelBoolean = ResponseModel<bool>;
typedef ResponseModelInt = ResponseModel<int>;
typedef ResponseModelDouble = ResponseModel<double>;

class ResponseModel<T> {
  late String code;
  dynamic _data;
  T get data => _data;
  bool get success => code == "SUCCESS";
  String get message => "ErrorCodes.$code".tr();

  ResponseModel(this.code, [this._data]);

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] is T && json["code"] == "SUCCESS") {
      return ResponseModel<T>(json["code"], json["data"] as T);
    } else {
      return ResponseModel(json["code"]);
    }
  }

  ResponseModel.error() : code = "ERROR";
}
