import 'package:flutter/material.dart';
import '../constants/themes.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.placeholder,
    this.initialValue,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
    this.autofocus = false,
    this.borderColor = ArgonColors.border,
    this.isPassword = false,
    this.readOnly = false,
    this.validator,
    this.controller,
  });

  final String? placeholder;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool autofocus;
  final Color borderColor;
  final bool isPassword;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      cursorColor: ArgonColors.muted,
      onTap: onTap,
      validator: validator,
      onChanged: onChanged,
      obscureText: isPassword,
      initialValue: initialValue,
      controller: controller,
      autofocus: autofocus,
      style: const TextStyle(
        height: 0.85,
        fontSize: 14.0,
        color: ArgonColors.initial,
      ),
      textAlignVertical: const TextAlignVertical(y: 0.6),
      decoration: InputDecoration(
        filled: true,
        fillColor: ArgonColors.white,
        hintStyle: const TextStyle(
          color: ArgonColors.muted,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
              color: ArgonColors.error, width: 1.0, style: BorderStyle.solid),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
              color: ArgonColors.error, width: 1.0, style: BorderStyle.solid),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
              color: borderColor, width: 1.0, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
              color: borderColor, width: 1.0, style: BorderStyle.solid),
        ),
        hintText: placeholder,
      ),
    );
  }
}
