import 'dart:convert';

CreateTransactionModel createTransactionModelFromJson(String str) => CreateTransactionModel.fromJson(json.decode(str));

String createTransactionModelToJson(CreateTransactionModel data) => json.encode(data.toJson());

class CreateTransactionModel {
    CreateTransactionModel({
       required this.statusCode,
       required this.data,
       required this.success,
    });

    int statusCode;
    bool data;
    bool success;

    factory CreateTransactionModel.fromJson(Map<String, dynamic> json) => CreateTransactionModel(
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
