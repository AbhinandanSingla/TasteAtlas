enum categoryType {
  pizza,
  burger,
  noodle,
  sandwich,
  roti // values
}

class category {
  final String url;
  final String name;
  category({ this.url, this.name});
}

class foodCategory {
  final String url;
  final String name;
final String id;
  final String price;
  final String Originalprice;
  final bool wishlist;

  foodCategory( {this.url, this.name, this.price, this.Originalprice,this.id,
      this.wishlist});
}
