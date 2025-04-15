class User1 {
  int? id;
  String? fullName;
  String? phone;
  int? price;
  String? registerDate;
  String? endDate;
  int? registerType;

  User1({
    this.id,
    this.fullName,
    this.phone,
    this.price,
    this.registerDate,
    this.endDate,
    this.registerType,
  });
  User1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['FullName'];
    phone = json['Phone'];
    price = json['Price'];
    registerDate = json['RegisterDate'];
    endDate = json['EndDate'];
    registerType = json['RegisterType'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'FullName': fullName,
      'Phone': phone,
      'Price': price,
      'RegisterDate': registerDate,
      'EndDate': endDate,
      'RegisterType': registerType,
    };
  }
}
