import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int uid;
  final String name;
  final String lastName;
  final String email;
  final String photo;
  final String phone;

  User({
    this.uid,
    this.name,
    this.lastName,
    this.email,
    this.photo,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      photo: json['photo'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['phone'] = this.phone;
    return data;
  }

  @override
  List<Object> get props => [
        this.uid,
        this.name,
        this.lastName,
        this.email,
        this.photo,
        this.phone,
      ];
}
