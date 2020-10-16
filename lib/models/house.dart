import 'package:equatable/equatable.dart';

class House extends Equatable {
  final String id;
  final List<int> services;
  final String title;
  final String type;
  final String description;
  final int ownerId;
  final String addressLine;
  final String zipCode;
  final String city;
  final String state;
  final String country;
  final int cost;
  final int roommatesLimit;
  final int roommatesCount;
  final String playlistUrl;
  final String foto;
  final int hid;

  House(
      {this.id,
      this.services,
      this.title,
      this.type,
      this.description,
      this.ownerId,
      this.addressLine,
      this.zipCode,
      this.city,
      this.state,
      this.country,
      this.cost,
      this.roommatesLimit,
      this.roommatesCount,
      this.playlistUrl,
      this.foto,
      this.hid});

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      id: json['_id'],
      services: json['services'].cast<int>(),
      title: json['title'],
      type: json['type'],
      description: json['description'],
      ownerId: json['ownerId'],
      addressLine: json['addressLine'],
      zipCode: json['zipCode'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      cost: json['cost'],
      roommatesLimit: json['roommatesLimit'],
      roommatesCount: json['roommatesCount'],
      playlistUrl: json['playlistURL'],
      foto: json['foto'],
      hid: json['hid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['services'] = this.services;
    data['title'] = this.title;
    data['type'] = this.type;
    data['description'] = this.description;
    data['ownerId'] = this.ownerId;
    data['addressLine'] = this.addressLine;
    data['zipCode'] = this.zipCode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['cost'] = this.cost;
    data['roommatesLimit'] = this.roommatesLimit;
    data['roommatesCount'] = this.roommatesCount;
    data['playlistURL'] = this.playlistUrl;
    data['foto'] = this.foto;
    data['hid'] = this.hid;
    return data;
  }

  @override
  List<Object> get props => [
        this.id,
        this.services,
        this.title,
        this.type,
        this.description,
        this.ownerId,
        this.addressLine,
        this.zipCode,
        this.city,
        this.state,
        this.country,
        this.cost,
        this.roommatesLimit,
        this.roommatesCount,
        this.playlistUrl,
        this.foto,
        this.hid
      ];
}
