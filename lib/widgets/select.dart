import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../constants/themes.dart';

class Select extends StatelessWidget {
  const Select({
    super.key,
    this.onChanged,
    this.readOnly = false,
    this.validator,
    this.clearOption = false,
    this.controller,
    this.searchEnabled = false,
    required this.dropDownList,
  });

  final Function(dynamic)? onChanged;
  final SingleValueDropDownController? controller;
  final bool readOnly;
  final bool searchEnabled;
  final bool clearOption;
  final String? Function(String?)? validator;
  final List<DropDownValueModel> dropDownList;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      controller: controller,
      clearOption: clearOption,
      enableSearch: searchEnabled,
      clearIconProperty: IconProperty(color: ArgonColors.muted),
      searchDecoration: const InputDecoration(
        hintText: "enter your custom hint text here",
      ),
      validator: validator,
      dropDownItemCount: dropDownList.length,
      dropDownList: dropDownList,
      onChanged: onChanged,
      textFieldDecoration: InputDecoration(
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
          borderSide: const BorderSide(
              color: ArgonColors.border, width: 1.0, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: ArgonColors.border,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        hintText: "Select Item",
      ),
    );
  }
}
