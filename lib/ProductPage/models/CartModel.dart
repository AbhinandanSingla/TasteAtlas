class CartModel {
  final String name;
  final String id;
  int quantity;
  final int price;
final int index;
final String url;
bool isFirstTime;
  CartModel( {this.isFirstTime,this.url,this.index,this.name, this.id, this.price, this.quantity});
}
