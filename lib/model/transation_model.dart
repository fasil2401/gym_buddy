// To parse this JSON data, do
//
//     final transactionListModel = transactionListModelFromJson(jsonString);

import 'dart:convert';

TransactionListModel transactionListModelFromJson(String str) => TransactionListModel.fromJson(json.decode(str));

String transactionListModelToJson(TransactionListModel data) => json.encode(data.toJson());

class TransactionListModel {
    TransactionListModel({
       required this.statusCode,
       required this.data,
       required this.success,
    });

    int statusCode;
    Data data;
    bool success;

    factory TransactionListModel.fromJson(Map<String, dynamic> json) => TransactionListModel(
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
       required this.transactions,
       required this.total,
       required this.pages,
       required this.page,
       required this.pageSize,
    });

    List<Transaction> transactions;
    int total;
    int pages;
    int page;
    int pageSize;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
        total: json["total"],
        pages: json["pages"],
        page: json["page"],
        pageSize: json["pageSize"],
    );

    Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "total": total,
        "pages": pages,
        "page": page,
        "pageSize": pageSize,
    };
}

class Transaction {
    Transaction({
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
    String customer;
    Package package;
    String notes;
    DateTime date;
    bool status;
    int amount;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        trxId: json["trxId"],
        customer: json["customer"],
        package: Package.fromJson(json["package"]),
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
        "customer": customer,
        "package": package.toJson(),
        "notes": notes,
        "date": date.toIso8601String(),
        "status": status,
        "amount": amount,
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
