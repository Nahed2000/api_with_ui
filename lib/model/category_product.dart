class CategoriesProducts {
  late int id;
  late String name;
  late String description;
  late String image;
  late String price;
  late String visible;
  late String quantity;
  late String color;
  late String categoryId;

  CategoriesProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    visible = json['visible'];
    quantity = json['quantity'];
    color = json['color'];
    categoryId = json['category_id'];
  }
}
