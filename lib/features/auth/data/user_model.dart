class UserModel {
  final String name;
  final String email;
  final String? image;
  final String? address;
  final String? visa;
  final String? token;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.address,
    this.token,
    this.visa,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      image: json['image'],
      token: json['token'],
      address: json['address'],
      visa: json['Visa'],
    );
  }
}
