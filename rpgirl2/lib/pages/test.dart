import 'package:flutter/material.dart';
import 'package:rpgirl2/widgets/welcome_scaffold.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WelocomeScaffold(
     // child: Text('welcome'),
      height: 100,
      width: 100,
      child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max, 
                  children: [
                    ///***If you have exported images you must have to copy those images in assets/images directory.
                   Image(
                        image: AssetImage("lib/assets/images/default.png"),
                        height: 240,
                        width: 240,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 8),
                        child: TextField(
                          controller: TextEditingController(),
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(
                                  color: Color(0x00ffffff), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(
                                  color: Color(0x00ffffff), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(
                                  color: Color(0x00ffffff), width: 1),
                            ),
                            hintText: "Username",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0xfff2f2f3),
                            isDense: false,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                        ),
                      ),

                      TextField(
                        controller: TextEditingController(),
                        obscureText: true,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                          ),
                          hintText: "Password",
                          
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          filled: true,
                          fillColor: Color(0xfff2f2f3),
                          isDense: false,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          suffixIcon: Icon(Icons.visibility_off,
                              color: Color(0xff212435), size: 24),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          onPressed: () {},
                          color: Color(0x00ffffff),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side:
                                BorderSide(color: Color(0x00ffffff)),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          textColor: Color(0xffffffff),
                          height: 40,
                          minWidth: 140,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                        child: MaterialButton(
                          onPressed: () {},
                          color: Color(0xff8a0ad5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          padding: EdgeInsets.all(16),
                          textColor: Color(0xffffffff),
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Don't have an account?",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xffbab4b4),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text(
                              "Sign Up",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          
                        ],
                      ),

                       Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                        child: Text(
                          "Login with Social Network",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xffbab4b4),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ///***If you have exported images you must have to copy those images in assets/images directory.
                          Image(
                            image: AssetImage("lib/assets/images/search.png"),
                            height: 35,
                            width: 35,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                            child:

                                ///***If you have exported images you must have to copy those images in assets/images directory.
                                Image(
                              image: AssetImage("lib/assets/images/social.png"),
                              height: 35,
                              width: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                            child:

                                ///***If you have exported images you must have to copy those images in assets/images directory.
                                Image(
                              image: AssetImage("lib/assets/images/discord.png"),
                              height: 35,
                              width: 35,
                              fit: BoxFit.cover,
                            ),
                          ),

                          ///***If you have exported images you must have to copy those images in assets/images directory.
                          Image(
                            image: AssetImage("lib/assets/images/github.png"),
                            height: 35,
                            width: 35,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                  ]  
                ),
    );
  }


}


