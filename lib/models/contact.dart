import 'package:equatable/equatable.dart';

class Contact extends Equatable  {
	final int uid;
	final int userId;
	final String name;
	final String lastName;
	final String email;
	final String phone;

	Contact({this.uid, this.userId, this.name, this.lastName, this.email, this.phone});

	factory Contact.fromJson(Map<String, dynamic> json) {
		return Contact(
			uid: json['uid'],
			userId: json['userId'],
			name: json['name'],
			lastName: json['lastName'],
			email: json['email'],
			phone: json['phone'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['userId'] = this.userId;
		data['name'] = this.name;
		data['lastName'] = this.lastName;
		data['email'] = this.email;
		data['phone'] = this.phone;
		return data;
	}

	@override
	List<Object> get props => [
		this.uid,
		this.userId,
		this.name,
		this.lastName,
		this.email,
		this.phone
	];
}
