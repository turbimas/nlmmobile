import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
=======
import 'package:koyevi/core/services/theme/custom_theme_data.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

extension RoundedImage on Image {
  ClipRRect get frd => ClipRRect(
        borderRadius: CustomThemeData.fullInfiniteRounded,
        child: this,
      );
}
