import 'package:flutter/material.dart';
import 'package:pattern_bloc/data/model/model.dart';


class StarCount extends StatefulWidget {


  @override
  _StarCountState createState() => _StarCountState();
}

class _StarCountState extends State<StarCount> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:  Row(
          children: [
            InkWell(
              child: Container(
                width: 64,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color(0xff242424),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Black",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff242424),
                      fontSize: 12,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              onTap: (){


              },
            ),
            SizedBox(width: 10),
            InkWell(
              child: Container(
                width: 64,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xfff2c94c),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Yellow",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              onTap: (){},
            ),
            SizedBox(width: 10),
            InkWell(
              child: Container(
                width: 64,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color(0xffdd3935),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Red",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffdd3935),
                      fontSize: 12,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              onTap: (){},
            ),
            SizedBox(width: 10),
            InkWell(
              child: Container(
                width: 64,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color(0xff2f80ed),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Blue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff2f80ed),
                      fontSize: 12,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              onTap: (){},
            ),
          ],
        ),

    );
  }
}
