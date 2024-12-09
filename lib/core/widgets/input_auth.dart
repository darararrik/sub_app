import 'package:flutter/material.dart';
import 'package:sub_app/core/widgets/text_field_widget.dart';

class InputAuth extends StatelessWidget {
  const InputAuth({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.validator,
    required this.obscureText,
  });

  final String label;
  final String hintText;
  final Widget icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: theme.textTheme.titleSmall,
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        TextFieldWidget(
          hintText: hintText,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          showLabel: false,
        ),
      ],
    );
  }
}
