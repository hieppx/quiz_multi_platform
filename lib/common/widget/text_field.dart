import 'package:flutter/material.dart';
import 'package:quiz_multi_platform/generated/l10n.dart';

class BasicTextField extends StatelessWidget {
  const BasicTextField(
      {super.key,
      required this.controller,
      this.hintext,
      this.isObscure,
      this.label,
      this.keyboardType,
      required this.width,
      this.enabled,
      this.onChange,
      required this.icon});
  final TextEditingController controller;
  final String? hintext;
  final bool? isObscure;
  final String? label;
  final TextInputType? keyboardType;
  final double? width;
  final bool? enabled;
  final Function(String)? onChange;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${S.of(context).input} ${label!.toLowerCase()} !';
          }
          return null;
        },
        obscureText: isObscure ?? false,
        controller: controller,
        onChanged: onChange,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: icon,
            enabled: enabled ?? true,
            label: Text(label ?? ''),
            filled: true,
            border: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6)))),
      ),
    );
  }
}
