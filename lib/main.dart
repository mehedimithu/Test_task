import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/bloc/product_bloc.dart';
import 'package:pattern_bloc/ui/home_page.dart';
import 'bloc/product_state.dart';
import 'data/repositories/product_repositories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) =>
            ProductBloc(productRepo: ProductRepoImpl()),
        child: HomePage(),
      ),
    );
  }
}
