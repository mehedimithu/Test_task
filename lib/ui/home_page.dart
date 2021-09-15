import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/bloc/product_bloc.dart';
import 'package:pattern_bloc/bloc/product_event.dart';
import 'package:pattern_bloc/bloc/product_state.dart';
import 'package:pattern_bloc/data/model/model.dart';

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        // actions: [
        //   Image.asset("assets/images/vector.png"),
        // ],
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
    return ListView.builder(
      itemCount: productModel!.categoryList!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: ClipOval(
                // child: Hero(
                //   child: Container(),
                //   tag: productModel.bannerImageLink!,
                //   // child: Image.network(
                //   //   productModel!.bannerImage,
                //   //   fit: BoxFit.cover,
                //   //   height: 70.0,
                //   //   width: 70.0,
                //   // ),
                // ),
                ),
            title: Text(productModel.categoryList![index].id.toString()),
            subtitle: Text(productModel.productPrice.toString()),
          ),
        );
      },
    );
  }
}
