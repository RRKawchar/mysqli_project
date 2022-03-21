class Data {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? roll;
  String? technology;

  Data(
      {this.id, this.name, this.phone, this.email, this.roll, this.technology});

  Data.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    roll = json['roll'];
    technology = json['technology'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['roll'] = this.roll;
    data['technology'] = this.technology;
    return data;
  }
}