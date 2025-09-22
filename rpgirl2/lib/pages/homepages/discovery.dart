///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/
library;

import 'package:flutter/material.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(0),
        shrinkWrap: false,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.16,
            decoration: BoxDecoration(
              color: Color(0xff8a0ad5),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width * 0.22,
                        decoration: BoxDecoration(
                          color: Color(0xff5f0891),
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xff4f26f2), width: 4),
                        ),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnU51nT1oTVqlg4usgiBuPSwzugdOqZ22haA&s",
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: Color(0x1f000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.zero,
                          border:
                              Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Text(
                          "Jeff Stepherman",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0x00000000),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        Image(
                          image:
                              NetworkImage("https://picsum.photos/250?image=9"),
                          height: MediaQuery.of(context).size.height *
                              0.35000000000000003,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite),
                                onPressed: () {},
                                color: Color(0xff212435),
                                iconSize: 24,
                              ),
                              Text(
                                "0",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.chat),
                                onPressed: () {},
                                color: Color(0xff212435),
                                iconSize: 24,
                              ),
                              Text(
                                "0",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                          child: 
                              
                            
                              Text(
                                "User description bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb ",
                                textAlign: TextAlign.start,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                           
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                          child: Text(
                            "April 20, 2015",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 10,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.12,
                        width: MediaQuery.of(context).size.width * 0.12,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                            "https://picsum.photos/250?image=9",
                            fit: BoxFit.cover),
                      ),
                      Text(
                        "User",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
