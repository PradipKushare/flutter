class Photo {
  final String name;
  final String email;
  final String phone;
  final String website;
  final int id;


  Photo._({this.name, this.email, this.phone, this.website,this.id});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo._(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      id: json['id'],
      

    );
  }
}