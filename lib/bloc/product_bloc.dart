import 'package:bloc/bloc.dart';
import 'package:pattern_bloc/bloc/product_event.dart';
import 'package:pattern_bloc/bloc/product_state.dart';
import 'package:pattern_bloc/data/repositories/product_repositories.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepo? productRepo;

  ProductBloc({required this.productRepo}) : super(ProductInitialState());

  @override
  ProductState get initialState => ProductInitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductsEvent) {
      yield ProductLoadinglState();
      try {
        var products = await productRepo!.getProducts();
        yield ProductLoadedState(productModel: products);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
  }
}
