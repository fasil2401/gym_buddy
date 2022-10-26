
import 'dart:convert';

UpdateMemberModel updateMemberModelFromJson(String str) => UpdateMemberModel.fromJson(json.decode(str));

String updateMemberModelToJson(UpdateMemberModel data) => json.encode(data.toJson());

class UpdateMemberModel {
    UpdateMemberModel({
       required this.statusCode,
       required this.data,
       required this.success,
    });

    int statusCode;
    Data data;
    bool success;

    factory UpdateMemberModel.fromJson(Map<String, dynamic> json) => UpdateMemberModel(
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
        "success": success,
    };
}

class Data {
    Data({
        this.acknowledged,
        this.modifiedCount,
        this.upsertedId,
        this.upsertedCount,
        this.matchedCount,
    });

    bool? acknowledged;
    int? modifiedCount;
    dynamic upsertedId;
    int? upsertedCount;
    int? matchedCount;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        acknowledged: json["acknowledged"],
        modifiedCount: json["modifiedCount"],
        upsertedId: json["upsertedId"],
        upsertedCount: json["upsertedCount"],
        matchedCount: json["matchedCount"],
    );

    Map<String, dynamic> toJson() => {
        "acknowledged": acknowledged,
        "modifiedCount": modifiedCount,
        "upsertedId": upsertedId,
        "upsertedCount": upsertedCount,
        "matchedCount": matchedCount,
    };
}
