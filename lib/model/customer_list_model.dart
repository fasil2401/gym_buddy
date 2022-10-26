import 'dart:convert';

CustomerListModel customerListModelFromJson(String str) =>
    CustomerListModel.fromJson(json.decode(str));

String customerListModelToJson(CustomerListModel data) =>
    json.encode(data.toJson());

class CustomerListModel {
  CustomerListModel({
    required this.statusCode,
    required this.data,
    required this.success,
  });

  int statusCode;
  Datas data;
  bool success;

  factory CustomerListModel.fromJson(Map<String, dynamic> json) =>
      CustomerListModel(
        statusCode: json["statusCode"],
        data: Datas.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
        "success": success,
      };
}

class Datas {
  Datas({
    required this.customers,
    required this.total,
    required this.pages,
    required this.page,
    required this.pageSize,
  });

  List<Customer> customers;
  int total;
  int pages;
  int page;
  int pageSize;

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        customers: List<Customer>.from(
            json["customers"].map((x) => Customer.fromJson(x))),
        total: json["total"],
        pages: json["pages"],
        page: json["page"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
        "total": total,
        "pages": pages,
        "page": page,
        "pageSize": pageSize,
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.mobile,
    this.gender,
    this.age,
    this.job,
    this.pincode,
    this.state,
    this.district,
    this.area,
    this.address,
    this.weight,
    this.height,
    this.score,
    required this.joiningDate,
    this.aadhaar,
    required this.package,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    this.v,
  });

  String? id;
  String? name;
  String? mobile;
  String? gender;
  int? age;
  String? job;
  String? pincode;
  String? state;
  String? district;
  String? area;
  String? address;
  int? weight;
  int? height;
  double? score;
  DateTime joiningDate;
  String? aadhaar;
  Package package;
  bool? status;
  DateTime createdAt;
  DateTime updatedAt;
  int? v;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        name: json["name"],
        mobile: json["mobile"],
        gender: json["gender"],
        age: json["age"],
        job: json["job"],
        pincode: json["pincode"],
        state: json["state"],
        district: json["district"],
        area: json["area"],
        address: json["address"],
        weight: json["weight"],
        height: json["height"],
        score: json["score"].toDouble(),
        joiningDate: DateTime.parse(json["joiningDate"]),
        aadhaar: json["aadhaar"],
        package: Package.fromJson(json["package"]),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobile": mobile,
        "gender": gender,
        "age": age,
        "job": job,
        "pincode": pincode,
        "state": state,
        "district": district,
        "area": area,
        "address": address,
        "weight": weight,
        "height": height,
        "score": score,
        "joiningDate": joiningDate.toIso8601String(),
        "aadhaar": aadhaar,
        "package": package.toJson(),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Package {
  Package({
    required this.status,
    required this.id,
    required this.name,
    required this.price,
  });

  bool status;
  String id;
  String name;
  int price;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        status: json["status"],
        id: json["_id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "name": name,
        "price": price,
      };
}
