import 'package:flutter/material.dart';

class CtextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
 final Color buttonColor;
  const CtextButton({
    super.key,
    required this.onPressed,
    required this.text, required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
       backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)
            )),
        overlayColor:
            MaterialStateProperty.all(Theme.of(context).badgeTheme.textColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Icon(
          //   Icons.upload_file,
          //   color: Colors.white,
          // ),
          // const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
