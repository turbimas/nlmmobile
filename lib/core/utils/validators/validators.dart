import 'package:easy_localization/easy_localization.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/utils/validators/auth_validators.dart';
=======
import 'package:koyevi/core/services/localization/locale_keys.g.dart';
import 'package:koyevi/core/utils/validators/auth_validators.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class Validators with AuthValidators {
  static final Validators _instance = Validators._();
  Validators._();
  static Validators get instance => _instance;

  String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.Validators_required.tr();
    }
    return null;
  }
}
