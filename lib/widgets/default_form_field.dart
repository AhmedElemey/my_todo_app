import 'package:flutter/material.dart';

Widget defaultFormField({
  TextEditingController? controller,
  TextInputType? type,
  ValueChanged<String>? onFieldSubmitted,
  ValueChanged<String>? onChanged,
  bool isPassword = false,
  GestureTapCallback? onTap,
  FormFieldValidator<String>? validator,
  String? label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
