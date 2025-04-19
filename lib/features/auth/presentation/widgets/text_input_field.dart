import 'package:flutter/material.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/core/extensions/spacing_extension.dart';
import 'package:task_out/core/constants/app_colors.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    super.key,
    required this.hintText,
    this.errorText,
    this.obscureText = false,
    this.isPasswordField = false,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  final String hintText;
  final String? errorText;
  final bool obscureText;
  final bool isPasswordField;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMd / 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
            border: Border.all(
              color:
                  widget.errorText != null
                      ? Colors.redAccent
                      : AppColors.mainColor,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            obscureText:
                widget.isPasswordField ? _isObscured : widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            style: TextStyle(
              fontSize: AppSizes.textMd,
              color: AppColors.mainColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              suffixIcon:
                  widget.isPasswordField
                      ? GestureDetector(
                        onTap: _toggleVisibility,
                        child: Icon(
                          _isObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.mainColor,
                        ),
                      )
                      : widget.suffixIcon,
              contentPadding: EdgeInsets.symmetric(
                vertical: AppSizes.blockHeight * 2,
              ),
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          AppSizes.blockHeight.h,
          Padding(
            padding: EdgeInsets.only(left: AppSizes.paddingMd),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ],
    );
  }
}
