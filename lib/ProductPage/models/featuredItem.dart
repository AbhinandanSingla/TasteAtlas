class FeaturedItem {
  final int price;
  final String name;
  final String rating;
  final bool wishlisted;
  final int min;
  final int max;
  final String desc;
  final String url;
  final String id;
  bool isFirstTime;
  int quantity;
  int priority;

  FeaturedItem({
    this.id,
    this.min,
    this.max,
    this.desc,
    this.url,
    this.price,
    this.name,
    this.rating,
    this.wishlisted,
    this.isFirstTime,
    this.quantity,
    this.priority,
  });
}
