

import 'dart:convert';

PackageModel packageModelFromJson(String str) => PackageModel.fromJson(json.decode(str));

String packageModelToJson(PackageModel data) => json.encode(data.toJson());

class PackageModel {
    PackageModel({
       required this.statusCode,
       required this.packages,
       required this.success,
    });

    int statusCode;
    List<Datum> packages;
    bool success;

    factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        statusCode: json["statusCode"],
        packages: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": List<dynamic>.from(packages.map((x) => x.toJson())),
        "success": success,
    };
}

class Datum {
    Datum({
        this.status,
        this.id,
        this.name,
        this.price,
    });

    bool? status;
    String? id;
    String? name;
    dynamic price;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
