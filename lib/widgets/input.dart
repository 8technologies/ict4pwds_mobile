import 'package:flutter/material.dart';
import '../constants/themes.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.autofocus = false,
      this.borderColor = ArgonColors.border,
      this.isPassword = false,
      this.controller});

  final String? placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool autofocus;
  final Color borderColor;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: ArgonColors.muted,
        onTap: onTap,
        onChanged: onChanged,
        obscureText: isPassword,
        controller: controller,
        autofocus: autofocus,
        style: const TextStyle(
            height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
        textAlignVertical: const TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: ArgonColors.white,
            hintStyle: const TextStyle(
              color: ArgonColors.muted,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
