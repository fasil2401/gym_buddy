import 'dart:convert';

// MemberModel memberModelFromJson(String str) =>
//     MemberModel.fromJson(json.decode(str));

// String memberModelToJson(MemberModel data) => json.encode(data.toJson());

class MemberModel {
  MemberModel({
    required this.packageName,
    required this.id,
    required this.name,
    required this.mobile,
    required this.gender,
    required this.job,
    required this.pincode,
    required this.state,
    required this.district,
    required this.area,
    required this.address,
    required this.weight,
    required this.height,
    required this.age,
    required this.score,
    required this.joiningDate,
    required this.aadhaar,
    required this.package,
    required this.status,
  });
  String packageName;
  String id;
  String name;
  String mobile;
  String gender;
  String job;
  String pincode;
  String state;
  String district;
  String area;
  String address;
  dynamic weight;
  dynamic height;
  dynamic age;
  dynamic score;
  String joiningDate;
  String aadhaar;
  String package;
  bool status;

  // factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
  //       name: json["name"],
  //       mobile: json["mobile"],
  //       gender: json["gender"],
  //       job: json["job"],
  //       pincode: json["pincode"],
  //       state: json["state"],
  //       district: json["district"],
  //       area: json["area"],
  //       address: json["address"],
  //       weight: json["weight"],
  //       height: json["height"],
  //       age: json["age"],
  //       score: json["score"],
  //       joiningDate: json["joiningDate"],
  //       aadhaar: json["aadhaar"],
  //       package: json["package"],
  //       status: json["status"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "name": name,
  //       "mobile": mobile,
  //       "gender": gender,
  //       "job": job,
  //       "pincode": pincode,
  //       "state": state,
  //       "district": district,
  //       "area": area,
  //       "address": address,
  //       "weight": weight,
  //       "height": height,
  //       "age": age,
  //       "score": score,
  //       "joiningDate": joiningDate,
  //       "aadhaar": aadhaar,
  //       "package": package,
  //       "status": status,
  //     };
}
