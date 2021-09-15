import 'package:flutter/material.dart';
import 'package:pattern_bloc/data/model/model.dart';

class DetailPage extends StatelessWidget {
  Model? productModel;

  DetailPage({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Hero(
            tag: productModel!.image!,
            child: Image.network("jdkj"),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Text(
              productModel!.id.toString(),
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(5.0),
            child: Text(productModel!.bookingPrice.toString()),
          ),
        ],
      ),
    );
  }
}
