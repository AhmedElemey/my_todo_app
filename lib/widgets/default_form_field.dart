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
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(
            prefix,
            color: const Color(0xff935050),
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                    color: const Color(0xff935050),
                  ),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xff935050), width: 1.3),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xff935050), width: 1.3),
          ),
        ));
