import 'package:b2b/Helper/size.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Function onTap;
  const SubmitButton(
      {Key? key,
      required this.isLoading,
      required this.onTap,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () {
              onTap();
            },
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.transparent,
        minimumSize: Size(width(context), 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // <-- Radius
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
    );
  }
}
