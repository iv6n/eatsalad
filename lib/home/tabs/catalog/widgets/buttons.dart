import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.155,
      height: size.height * 0.03,
      color: Colors.transparent,
      child: OutlinedButton(
        onPressed: null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            size: 22,
            color: Colors.green[700],
          ),
        ),
      ),
    );
  }
}
