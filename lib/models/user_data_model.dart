class UserModel {
  late String email;
  late String uId;
  late String image;
  late String cover;
  late String bio;
  late bool isEmailVerified;

  UserModel({
    required this.email,
    required this.uId,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
