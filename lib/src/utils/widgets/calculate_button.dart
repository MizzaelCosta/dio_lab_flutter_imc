import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 8,
          textStyle: const TextStyle(
            fontSize: 24,
          ),
          minimumSize: Size(MediaQuery.of(context).size.width, 55)),
      onPressed: onPressed,
      child: child,
    );
  }
}
