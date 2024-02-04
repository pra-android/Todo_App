import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? press;

  CustomIconButton({required this.icon, required this.press});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: IconButton(
        icon: icon,
        onPressed: press,
      ),
    );
  }
}
