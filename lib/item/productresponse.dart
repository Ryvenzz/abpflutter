import 'product.dart';

class ProductResponse {
  final String nickname;
  final List<Product> products;

  ProductResponse({required this.nickname, required this.products});
}
