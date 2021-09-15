import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {}

class FetchProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
