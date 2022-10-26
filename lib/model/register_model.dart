
import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    RegisterModel({
       required this.statusCode,
       required this.data,
       required this.success,
    });

    int statusCode;
    bool data;
    bool success;

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        statusCode: json["statusCode"],
        data: json["data"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data,
        "success": success,
    };
}
