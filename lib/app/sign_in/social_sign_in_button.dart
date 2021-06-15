import 'package:flutter/material.dart';
import 'package:time_traker_flutter_course/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton{
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }): assert(text != null),//asset 사용시 어떤값을 안넣었는지 알려줌 bull 이 false 이면
      assert(assetName != null),
        super(//custom_raised_button 에게 값들 줌 s
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(assetName),
          Text(text,
              style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          Opacity(//투명도 child 로는 구글이미지
              opacity: 0.0,
              child: Image.asset(assetName)),
        ]

    ),
    color: color,
    onPressed: onPressed,
  );
}
