import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String? text;
  final Future<int?> dataBaseHandler;

  CustomElevatedButton({
    this.text,
    required this.dataBaseHandler,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.pop(context);
        setState(() {});
      },
      child: Text(widget.text.toString()),
    );
  }
}
