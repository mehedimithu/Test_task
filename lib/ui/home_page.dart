import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pattern_bloc/bloc/product_bloc.dart';
import 'package:pattern_bloc/bloc/product_event.dart';
import 'package:pattern_bloc/bloc/product_state.dart';
import 'package:pattern_bloc/data/model/model.dart';

import 'details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductBloc? productBloc;


  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc!.add(FetchProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          Image.asset('assets/images/vector.png'),
        ],
      ),
      body: Container(
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductErrorState) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text(state.message.toString())));
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductInitialState) {
                return buildLoading();
              } else if (state is ProductLoadinglState) {
                return buildLoading();
              } else if (state is ProductLoadedState) {
                return buildProducts(state.productModel);
              } else if (state is ProductErrorState) {
                return buildErrorUi(state.message);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String? message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message!,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildProducts(Model? productModel) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          width: 374.88,
          height: 240.74,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: ImageSlideshow(
              width: double.infinity,
              initialPage: 0,
              indicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              onPageChanged: (value) {
                print('Page changed: $value');
              },
              autoPlayInterval: 3000,
              children: [
                Image.network("${productModel!.image}", fit: BoxFit.cover),
                Image.network("${productModel!.image}", fit: BoxFit.cover),
                Image.network("${productModel!.brand!.image}",
                    fit: BoxFit.cover),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "${productModel.productName} Brand: ${productModel.brand!.name}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 375,
          height: 160.91,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              width: MediaQuery.of(context).size.width / 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "BDT ${productModel.productPrice}",
                              style: TextStyle(
                                color: Color(0xffdd3935),
                                fontSize: 15,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              " BDT ${00.00}",
                              style: TextStyle(
                                color: Color(0xff616161),
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 63.33,
                              height: 23.66,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffdd3935),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "0% Off",
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: double.parse(
                                "${productModel.productReviewAvg}"),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Select Color",
                      style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 20,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
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
                              color: Colors.blue,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Blue",
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
                                color: Color(0xfff2c94c),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Yellow",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xfff2c94c),
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

                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Delivery Information",
            style: TextStyle(
              color: Color(0xff242424),
              fontSize: 20,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset('assets/images/truckline.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.11),
              Text(
                "Sent from Dhaka, will arrive in 7/10 workdays",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Payment Method (Supported)",
            style: TextStyle(
              color: Color(0xff242424),
              fontSize: 20,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 321.63,
            height: 51.04,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 68.29,
                      height: 26,
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 15.53,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 15.53,
                                      height: 15.53,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xff27ae60),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 15.53,
                                      height: 15.53,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(
                                          'assets/images/group.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.29),
                          Text(
                            "Bkash",
                            style: TextStyle(
                              color: Color(0xff616161),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 236.81,
                      height: 26,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 16,
                            height: 15.53,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 15.53,
                                      height: 15.53,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xffff0600),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 15.53,
                                      height: 15.53,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(
                                          'assets/images/group1.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.81),
                          Text(
                            "Cash on Delivery not available",
                            style: TextStyle(
                              color: Color(0xff616161),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 68.02,
                      height: 26,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 16,
                            height: 15.53,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 15.53,
                                      height: 15.53,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xff27ae60),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 15.53,
                                      height: 15.53,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(
                                          'assets/images/group.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.02),
                          Text(
                            "Bkash",
                            style: TextStyle(
                              color: Color(0xff616161),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 84.98,
                  top: 23.76,
                  child: Container(
                    width: 67.72,
                    height: 26,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 16,
                          height: 15.53,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 15.53,
                                    height: 15.53,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xff27ae60),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 15.53,
                                    height: 15.53,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:
                                        Image.asset('assets/images/group.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 7.72),
                        Text(
                          "Bkash",
                          style: TextStyle(
                            color: Color(0xff616161),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 165.12,
                  top: 23.97,
                  child: Container(
                    width: 68.33,
                    height: 26,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 16,
                          height: 15.53,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 15.53,
                                    height: 15.53,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xff27ae60),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 15.53,
                                    height: 15.53,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:
                                        Image.asset('assets/images/group.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.33),
                        Text(
                          "Bkash",
                          style: TextStyle(
                            color: Color(0xff616161),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding:
                EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                "Description",
                style: TextStyle(
                  color: Color(0xff242424),
                  fontSize: 20,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                ),
              ),
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        child: Image.network("${productModel.brand!.image}")),
                    Text('${productModel.brand!.name}'),
                    Text('${productModel.categoryList![0].parent}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding:
                EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                "Additional Information",
                style: TextStyle(
                  color: Color(0xff242424),
                  fontSize: 20,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                ),
              ),
              children: [
                Column(
                  children: [
                    CircleAvatar(child: Image.network("${productModel.image}")),
                    Text('${productModel.productName}'),
                    Text('${productModel.buisnessName}'),
                    Text('Stock: ${productModel.stock}'),
                    Text('Product Price: ${productModel.productPrice}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
