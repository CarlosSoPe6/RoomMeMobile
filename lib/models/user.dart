import 'package:equatable/equatable.dart';

class User extends Equatable  {
	final int id;
	final String name;
	final String username;
	final String email;
	final String phone;
	final String website;

	User({this.id, this.name, this.username, this.email, this.phone, this.website});

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			id: json['id'],
			name: json['name'],
			username: json['username'],
			email: json['email'],
      phone: json['phone'],
			website: json['website']
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['username'] = this.username;
		data['email'] = this.email;
		data['phone'] = this.phone;
		data['website'] = this.website;
		return data;
	}

	@override
	List<Object> get props => [
		this.id,
		this.name,
		this.username,
		this.email,
		this.phone,
		this.website
	];
}
