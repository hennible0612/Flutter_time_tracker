//custom_raised_button.dart
import 'package:flutter/material.dart';

//stateless 위젯이므로 변수들은 final 이 되어야함
class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton(
      {this.child,
      this.color,
      this.borderRadius: 2.0,
      this.height: 50.0,
      this.onPressed}): assert(borderRadius != null); //아래 변수들은 컨스터럭터를 사용하여 값을 넣어야함//재사용이 가능하기 위해 변수 보내줌
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //SizedBox 사용시 height 사용가능
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
