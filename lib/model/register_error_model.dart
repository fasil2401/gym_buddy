
import 'dart:convert';

RegisterErrorModel registerErrorModelFromJson(String str) => RegisterErrorModel.fromJson(json.decode(str));

String registerErrorModelToJson(RegisterErrorModel data) => json.encode(data.toJson());

class RegisterErrorModel {
    RegisterErrorModel({
       required this.statusCode,
       required this.error,
       required this.path,
       required this.success,
    });

    int statusCode;
    String error;
    String path;
    bool success;

    factory RegisterErrorModel.fromJson(Map<String, dynamic> json) => RegisterErrorModel(
        statusCode: json["statusCode"],
        error: json["error"],
        path: json["path"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "error": error,
        "path": path,
        "success": success,
    };
}
