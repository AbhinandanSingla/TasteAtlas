class ProductsModel {
  final String id;
  final List add_ons;
  final String desc;
  final int min;
  final int max;
  final String name;
  String url;
  final String rating;
  final int price;
  int quantity;
  bool isFirstTime;
  final List tags;

  ProductsModel({
    this.tags,
    this.quantity,
    this.isFirstTime,
    this.id,
    this.desc,
    this.min,
    this.max,
    this.name,
    this.url,
    this.rating,
    this.price,
    this.add_ons,
  });
}
