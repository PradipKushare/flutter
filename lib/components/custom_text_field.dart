import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flamedemo/utils/colors.dart';
import 'package:flamedemo/utils/screen_util.dart';
import 'package:flamedemo/utils/text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String hintText;
  final String prefixText;
  final IconData icon;
  final String initialValue;
  final int maxLength;
  final TextInputType keyboardType;
  final bool enabled;
  final bool obscureText;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final controller;



  const AppTextFormField({
    Key key,
    this.onSaved,
    this.validator,
    this.hintText = "",
    this.prefixText,
    this.maxLength,
    this.icon,
    this.keyboardType,
    this.enabled = true,
    this.obscureText = false,
    this.initialValue,
    this.focusNode,
    this.onFieldSubmitted,
    this.controller,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.all(Radius.circular(Constant.sizeSmall))),
      //padding: EdgeInsets.all(Constant.sizeMedium),
      child: TextFormField(
        focusNode: focusNode,
        decoration: InputDecoration(
          icon: Icon(
            icon ?? Icons.email,
            size: Constant.texIconSize,
          ),
          hintText: hintText,
          hintStyle: TextStyles.labelStyle,
          errorStyle: TextStyles.errorStyle,
          prefixText: prefixText,
          errorMaxLines: 1,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
//        textAlign: TextAlign.center,
        inputFormatters: (maxLength != null)
            ? obscureText
                ? [LengthLimitingTextInputFormatter(maxLength), WhitelistingTextInputFormatter(RegExp("[0-9]"))]
                : [LengthLimitingTextInputFormatter(maxLength)]
            : [],
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        controller:controller,
        validator: validator,
        keyboardType: keyboardType,
        enabled: enabled,
        textInputAction: textInputAction,
        style: TextStyles.editText,
        obscureText: obscureText,
      ),
    );
  }
}
