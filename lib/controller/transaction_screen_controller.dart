import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym/model/create_transaction_model.dart';
import 'package:gym/model/register_error_model.dart';
import 'package:gym/model/transaction_by_id_model.dart';
import 'package:gym/model/transation_model.dart';
import 'package:gym/services/api_services.dart';
import 'package:gym/utils/date_formatter.dart';

class TransactionScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getTransactions();
  }

  var pageSizes = 15.obs;
  var pageNumber = 1.obs;
  var customerPageNumber = 1.obs;
  // var dateFrom = DateTime(2000).toString().obs;
  var dateToCheck = ''.obs;
  var filterStatus = ''.obs;

  var isLoading = false.obs;
  var respStatus = 0.obs;
  var respMessage = ''.obs;
  var transactions = [].obs;
  var userTransactions = [].obs;
  var customerName = ''.obs;
  var customerId = ''.obs;
  var transaction = TransactionByIdModel().obs;
  var searchQuery = ''.obs;
  var gender = ''.obs;
  var status = true.obs;
  var transactionDate = DateTime.now().obs;
  var transactionFee = 0.0.obs;
  var transactionNote = ''.obs;
  var packageAmount = 0.0.obs;
  var packageId = ''.obs;
  var fieldError = false.obs;

  setFilterStatus(String value) {
    value == 'Active'
        ? filterStatus.value = 'true'
        : filterStatus.value = 'false';

    getTransactions();
  }

  getTransactionFee(String value) {
    transactionFee.value = double.parse(value);
  }

  getTrabsactionNote(String value) {
    transactionNote.value = value;
  }

  getPackage(String value) {
    packageId.value = value;
  }

  getPackageAmount(String value) {
    packageAmount.value = double.parse(value);
  }

  nextPage() {
    pageNumber.value++;
    getTransactions();
  }

  nextUserPage() {
    customerPageNumber.value++;
    getUserTransactions(customerId.value, customerName.value);
  }

  previousUserPage() {
    if (customerPageNumber.value > 1) {
      customerPageNumber.value--;
      getUserTransactions(customerId.value, customerName.value);
    }
  }

  previousPage() {
    if (pageNumber.value > 1) {
      pageNumber.value--;
      getTransactions();
    }
  }

  selectDate(context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      dateToCheck.value = dateFormat.format(newDate).toString();
      print(dateToCheck.value);
      getTransactions();
    }

    update();
  }

  selectTransactionDate(context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      transactionDate.value = newDate;
      print(transactionDate.value);
    }

    update();
  }

  getTransactions() async {
    isLoading.value = true;
    var result;
    try {
      var feedback = await ApiManager.fetchDataGet(
          api:
              'transactions?page=${pageNumber.value}&date=${dateToCheck.value}&status=${filterStatus.value}');
      if (feedback != null) {
        result = TransactionListModel.fromJson(feedback);
        respStatus.value = result.statusCode;
      } else {}
    } finally {
      if (respStatus.value == 200) {
        transactions.clear();
        isLoading.value = false;
        transactions.value = result.data.transactions;
      } else {
        isLoading.value = false;
      }
    }
  }

  getTransactionById(String id) async {
    isLoading.value = true;
    var result;
    try {
      var feedback =
          await ApiManager.fetchDataGet(api: 'customers/transactions/${id}');
      if (feedback != null) {
        result = TransactionByIdModel.fromJson(feedback);
        respStatus.value = result.statusCode;
      } else {}
    } finally {
      if (respStatus.value == 200) {
        transaction.value = result;
        isLoading.value = false;
      } else {
        isLoading.value = false;
        transaction.value = null as TransactionByIdModel;
      }
    }
  }

  // getMemberTransaction(String id) async {
  //   isLoading.value = true;
  //   var result;
  //   try {
  //     var feedback = await ApiManager.fetchDataGet(
  //         api: 'customers/${id}/transactions?page=1');
  //     if (feedback != null) {
  //       result = TransactionByIdModel.fromJson(feedback);
  //       respStatus.value = result.statusCode;
  //     } else {}
  //   } finally {
  //     if (respStatus.value == 200) {
  //       transaction.value = result;
  //       isLoading.value = false;
  //     } else {
  //       isLoading.value = false;
  //       transaction.value = null as TransactionByIdModel;
  //     }
  //   }
  // }

  getUserTransactions(String id, String name) async {
    customerId.value = id;
    customerName.value = name;
    isLoading.value = true;
    var result;
    try {
      var feedback = await ApiManager.fetchDataGet(
          api: 'customers/${id}/transactions?page=${customerPageNumber.value}');
      if (feedback != null) {
        result = TransactionListModel.fromJson(feedback);
        respStatus.value = result.statusCode;
      } else {}
    } finally {
      if (respStatus.value == 200) {
        userTransactions.clear();
        isLoading.value = false;
        userTransactions.value = result.data.transactions;
      } else {
        isLoading.value = false;
      }
    }
  }

  createTransaction(BuildContext context) async {
    if (transactionFee.value != '' &&
        transactionNote.value != '' &&
        packageId.value != '') {
      final data = json.encode({
        "package": packageId.value,
        "notes": transactionNote.value,
        "date": dateFormat.format(transactionDate.value).toString(),
        "status": true,
        "amount": transactionFee.value,
      });
      print(data);
      isLoading.value = true;
      var result;
      try {
        var feedback = await ApiManager.fetchDataRawBody(
            api: 'customers/${customerId.value}/transactions', data: data);
        if (feedback != null && feedback['statusCode'] == 200) {
          result = CreateTransactionModel.fromJson(feedback);
          respStatus.value = result.statusCode;
          print(respStatus.value);
        } else {
          result = RegisterErrorModel.fromJson(feedback);
          respStatus.value = result.statusCode;
          print(respStatus.value);
        }
      } finally {
        if (respStatus.value == 200) {
          isLoading.value = false;
          resetFieldValues();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Transaction Done Successfully"),
          ));
          getUserTransactions(customerId.value, customerName.value);
        } else {
          isLoading.value = false;
        }
      }
    } else {
      fieldError.value = true;
    }
  }

  resetFieldValues() {
    transactionFee.value = 0.0;
    transactionNote.value = '';
    packageId.value = '';
    transactionDate.value = DateTime.now();
    fieldError.value = false;
  }
}
