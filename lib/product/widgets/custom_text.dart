import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  String data;
  TextStyle? style;
  int maxLines;
  TextAlign textAlign;
  CustomText(this.data,
      {this.style, this.maxLines = 1, this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textScaleFactor: 1.0,
      style: style,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

class CustomTextLocale extends StatelessWidget {
  String data;
  List<String> args;
  TextStyle? style;
  int maxLines;
  TextAlign textAlign;
  CustomTextLocale(this.data,
      {this.args = const [],
      this.style,
      this.maxLines = 1,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      data.tr(args: args),
      textScaleFactor: 1.0,
      style: style,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
