///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class verifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00ffffff),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
                  child: Text(
                    "Verification",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: NetworkImage(
                      "https://cdn4.iconfinder.com/data/icons/avatar-users/512/Avatar_Users2_15-128.png"),
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: Text(
                    "Enter the verification code we just send you on your email address.",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                OtpTextField(
                  numberOfFields: 6,
                  showFieldAsBox: false,
                  fieldWidth: 50,
                  filled: true,
                  fillColor: Color(0x00000000),
                  enabledBorderColor: Color(0xff898a8e),
                  focusedBorderColor: Color(0xff3a57e8),
                  borderWidth: 2,
                  margin: EdgeInsets.all(0),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  obscureText: false,
                  borderRadius: BorderRadius.circular(4.0),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Color(0xff000000),
                  ),
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "If you didn't receive a code!",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          color: Color(0xffffffff),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        color: Color(0x00ffffff),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Resend",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        textColor: Color(0xffffffff),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Color(0xff3a57e8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  textColor: Color(0xffffffff),
                  height: 50,
                  minWidth: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
