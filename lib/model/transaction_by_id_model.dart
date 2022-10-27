import 'dart:convert';

TransactionByIdModel transactionByIdModelFromJson(String str) => TransactionByIdModel.fromJson(json.decode(str));

String transactionByIdModelToJson(TransactionByIdModel data) => json.encode(data.toJson());

class TransactionByIdModel {
    TransactionByIdModel({
        this.statusCode,
        this.data,
        this.success,
    });

    int? statusCode;
    Data? data;
    bool? success;

    factory TransactionByIdModel.fromJson(Map<String, dynamic> json) => TransactionByIdModel(
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data!.toJson(),
        "success": success,
    };
}

class Data {
    Data({
       required this.id,
       required this.trxId,
       required this.customer,
       required this.package,
       required this.notes,
       required this.date,
       required this.status,
       required this.amount,
       required this.createdAt,
       required this.updatedAt,
       required this.v,
    });

    String id;
    String trxId;
    Customer customer;
    String package;
    String notes;
    DateTime date;
    bool status;
    int amount;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        trxId: json["trxId"],
        customer: Customer.fromJson(json["customer"]),
        package: json["package"],
        notes: json["notes"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "trxId": trxId,
        "customer": customer.toJson(),
        "package": package,
        "notes": notes,
        "date": date.toIso8601String(),
        "status": status,
        "amount": amount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Customer {
    Customer({
       required this.id,
       required this.name,
       required this.mobile,
       required this.gender,
       required this.age,
       required this.job,
       required this.pincode,
       required this.state,
       required this.district,
       required this.area,
       required this.address,
       required this.weight,
       required this.height,
       required this.score,
       required this.joiningDate,
       required this.aadhaar,
       required this.package,
       required this.status,
       required this.createdAt,
       required this.updatedAt,
       required this.v,
    });

    String id;
    String name;
    String mobile;
    String gender;
    int age;
    String job;
    String pincode;
    String state;
    String district;
    String area;
    String address;
    int weight;
    int height;
    int score;
    DateTime joiningDate;
    String aadhaar;
    String package;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

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
        score: json["score"],
        joiningDate: DateTime.parse(json["joiningDate"]),
        aadhaar: json["aadhaar"],
        package: json["package"],
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
        "package": package,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
