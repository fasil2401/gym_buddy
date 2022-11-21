import 'dart:convert';

MonthlyTransactionModel monthlyTransactionModelFromJson(String str) => MonthlyTransactionModel.fromJson(json.decode(str));

String monthlyTransactionModelToJson(MonthlyTransactionModel data) => json.encode(data.toJson());

class MonthlyTransactionModel {
    MonthlyTransactionModel({
       required this.statusCode,
       required this.data,
       required this.success,
    });

    int statusCode;
    Data data;
    bool success;

    factory MonthlyTransactionModel.fromJson(Map<String, dynamic> json) => MonthlyTransactionModel(
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
       required this.data,
        this.page,
        this.pageSize,
        this.total,
        this.pages,
    });

    List<Datum> data;
    int? page;
    int? pageSize;
    int? total;
    int? pages;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        page: json["page"],
        pageSize: json["pageSize"],
        total: json["total"],
        pages: json["pages"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "page": page,
        "pageSize": pageSize,
        "total": total,
        "pages": pages,
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.mobile,
       required this.transactions,
        this.paid,
    });

    String? id;
    String? name;
    String? mobile;
    List<Transaction> transactions;
    dynamic paid;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        mobile: json["mobile"],
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
        paid: json["paid"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobile": mobile,
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "paid": paid,
    };
}


class Transaction {
    Transaction({
        this.id,
        this.trxId,
       required this.date,
        this.amount,
    });

    String? id;
    String? trxId;
    DateTime date;
    dynamic amount;

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        trxId: json["trxId"],
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "trxId": trxId,
        "date": date.toIso8601String(),
        "amount": amount,
    };
}
