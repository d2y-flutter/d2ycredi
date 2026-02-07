import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefix;
  final Widget? suffix;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;
  final TextStyle? style;
  final TextCapitalization textCapitalization;
  final bool showCounter;

  const D2YTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.inputFormatters,
    this.autovalidateMode,
    this.focusNode,
    this.contentPadding,
    this.style,
    this.textCapitalization = TextCapitalization.none,
    this.showCounter = false,
  });

  // =========================
  // FACTORY HELPERS
  // =========================

  static Widget email({
    TextEditingController? controller,
    String? label,
    String? hint,
    String? errorText,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
  }) {
    return D2YTextField(
      controller: controller,
      label: label ?? 'Email',
      hint: hint,
      errorText: errorText,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      prefixIcon: Icons.email_outlined,
    );
  }

  static Widget password({
    TextEditingController? controller,
    String? label,
    String? hint,
    String? errorText,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
  }) {
    return D2YTextField(
      controller: controller,
      label: label ?? 'Password',
      hint: hint,
      errorText: errorText,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      prefixIcon: Icons.lock_outline,
    );
  }

  static Widget phone({
    TextEditingController? controller,
    String? label,
    String? hint,
    String? errorText,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
  }) {
    return D2YTextField(
      controller: controller,
      label: label ?? 'Phone',
      hint: hint,
      errorText: errorText,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      prefixIcon: Icons.phone_outlined,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }

  static Widget search({
    TextEditingController? controller,
    String? hint,
    ValueChanged<String>? onChanged,
    VoidCallback? onClear,
    FocusNode? focusNode,
  }) {
    return D2YTextField(
      controller: controller,
      hint: hint ?? 'Search...',
      prefixIcon: Icons.search,
      suffixIcon: controller?.text.isNotEmpty == true ? Icons.clear : null,
      onSuffixTap: onClear,
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: TextInputAction.search,
    );
  }

  static Widget multiline({
    TextEditingController? controller,
    String? label,
    String? hint,
    String? errorText,
    int maxLines = 5,
    int? maxLength,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    FocusNode? focusNode,
    bool showCounter = false,
  }) {
    return D2YTextField(
      controller: controller,
      label: label,
      hint: hint,
      errorText: errorText,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      showCounter: showCounter,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline, 
    );
  }

  @override
  State<D2YTextField> createState() => _D2YTextFieldState();
}

class _D2YTextFieldState extends State<D2YTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      maxLines: _obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: widget.autovalidateMode,
      textCapitalization: widget.textCapitalization,
      style: widget.style,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: AppColor.grey500)
            : null,
        prefix: widget.prefix,
        suffixIcon: _buildSuffixIcon(),
        suffix: widget.suffix,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLG,
              vertical: AppConstants.paddingMD,
            ),
        counterText: widget.showCounter ? null : '',
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColor.grey500,
        ),
        onPressed: () {
          setState(() => _obscureText = !_obscureText);
        },
      );
    }

    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon, color: AppColor.grey500),
        onPressed: widget.onSuffixTap,
      );
    }

    return null;
  }
}