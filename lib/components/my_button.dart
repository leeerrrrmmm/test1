import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final void Function()? onPressed;
  final String label;
  final Color? color;
  MyButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2, color: Colors.indigo)

        ),
        child: TextButton(
            onPressed: onPressed,
            child:Text(label,
            style:TextStyle(
              color:Colors.black
            )),
        ),
      ),
    );
  }
}
