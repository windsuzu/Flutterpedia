class User {
  int id;
  String name;
  String email;

  User(this.name, this.email);

  User.fromJsonMap(Map<String, dynamic> map)
      : id = map["_id"] as int,
        name = map["name"],
        email = map["email"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;

    if (data['_id'] != null) {
      data['_id'] = id;
    }
    return data;
  }
}
