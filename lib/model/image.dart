
class UserImage {
late int id;
late String image;
late String info;
late String userId;
late String visible;


  UserImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    info = json['info'];
    userId = json['user_id'];
    visible = json['visible'];
  }

}