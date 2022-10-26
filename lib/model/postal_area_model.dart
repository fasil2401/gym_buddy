

import 'dart:convert';

List<PinCodeModel> pinCodeModelFromJson(String str) => List<PinCodeModel>.from(json.decode(str).map((x) => PinCodeModel.fromJson(x)));

String pinCodeModelToJson(List<PinCodeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PinCodeModel {
    PinCodeModel({
       required this.message,
       required this.status,
       required this.postOffice,
    });

    String message;
    String status;
    List<PostOffice> postOffice;

    factory PinCodeModel.fromJson(Map<String, dynamic> json) => PinCodeModel(
        message: json["Message"],
        status: json["Status"],
        postOffice: List<PostOffice>.from(json["PostOffice"].map((x) => PostOffice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Message": message,
        "Status": status,
        "PostOffice": List<dynamic>.from(postOffice.map((x) => x.toJson())),
    };
}

class PostOffice {
    PostOffice({
        this.name,
        this.description,
        this.branchType,
        this.deliveryStatus,
        this.circle,
        this.district,
        this.division,
        this.region,
        this.block,
        this.state,
        this.country,
        this.pincode,
    });

    String? name;
    dynamic description;
    String? branchType;
    String? deliveryStatus;
    String? circle;
    String? district;
    String? division;
    String? region;
    String? block;
    String? state;
    String? country;
    String? pincode;

    factory PostOffice.fromJson(Map<String, dynamic> json) => PostOffice(
        name: json["Name"],
        description: json["Description"],
        branchType: json["BranchType"],
        deliveryStatus: json["DeliveryStatus"],
        circle: json["Circle"],
        district: json["District"],
        division: json["Division"],
        region: json["Region"],
        block: json["Block"],
        state: json["State"],
        country: json["Country"],
        pincode: json["Pincode"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Description": description,
        "BranchType": branchType,
        "DeliveryStatus": deliveryStatus,
        "Circle": circle,
        "District": district,
        "Division": division,
        "Region": region,
        "Block": block,
        "State": state,
        "Country": country,
        "Pincode": pincode,
    };
}
