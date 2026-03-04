import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final double? hintTextSize;
  final String? labelText;
  final double? height;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Color? borderColor;
  final bool filled;
  final bool readOnly;
  final bool showAsterisk;
  final String? Function(String?)? validators;
  final BorderRadius? borderRadius;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final double? fontSize;
  final int? maxLine;
  final bool obscure;
  final void Function()? suffixOnPressed;

  const CustomTextFieldWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.borderColor,
    this.filled = false,
    this.readOnly = false,
    this.showAsterisk = false,
    this.validators,
    this.borderRadius,
    this.enabledBorder,
    this.focusedBorder,
    this.fontSize,
    this.maxLine,
    this.height,
    this.hintTextSize,
    this.obscure = false,
    this.suffixOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width / 1,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validators,
        onChanged: onChanged,
        readOnly: readOnly,
        maxLines: maxLine,
        obscureText: obscure,
        style: TextStyle(
          fontSize: fontSize ?? 14,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
          fontFamily: 'inter',
        ),
        decoration: InputDecoration(
          hint: hintText != null
              ? RichText(
                  text: TextSpan(
                    text: hintText,
                    style: TextStyle(
                      fontSize: hintTextSize ?? 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                    children: [
                      showAsterisk
                          ? const TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.deepPurple),
                            )
                          : const TextSpan(text: ''),
                    ],
                  ),
                )
              : null,
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: filled,
          fillColor: AppColors.white,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: AppColors.grey, size: 18)
              : null,
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: suffixOnPressed, icon: Icon(suffixIcon))
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          enabledBorder:
              enabledBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor ?? AppColors.grey),
              ),
          focusedBorder:
              focusedBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.grey,
                  width: 1.5,
                ),
              ),
        ),
      ),
    );
  }
}
