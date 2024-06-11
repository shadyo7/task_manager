
import 'package:flutter/material.dart';
import 'package:task_manager/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        textStyle: textStyle ?? const TextStyle(fontSize: 16),
      ),
      child: Text(label,style: AppTextStyles.buttonTitle,),
    );
  }
}
