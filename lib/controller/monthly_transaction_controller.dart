import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym/model/monthly_transaction_model.dart';
import 'package:gym/model/transaction_by_id_model.dart';
import 'package:gym/services/api_services.dart';
import 'package:gym/utils/date_formatter.dart';

class MonthlyTransactionController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getMonthlyTransactions();
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

  removeFIlter() {
    dateToCheck.value = '';
    filterStatus.value = '';
    getMonthlyTransactions();
  }
  // setFilterStatus(String value) {
  //   value == 'Active'
  //       ? filterStatus.value = 'true'
  //       : filterStatus.value = 'false';

  //   getTransactions();
  // }

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
    getMonthlyTransactions();
  }

  previousPage() {
    if (pageNumber.value > 1) {
      pageNumber.value--;
      getMonthlyTransactions();
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
      getMonthlyTransactions();
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

  getMonthlyTransactions() async {
    isLoading.value = true;
    var result;
    try {
      var feedback = await ApiManager.fetchDataGet(
          api:
              'customers/monthly/transactions/status?page=${pageNumber.value}&date=${dateToCheck.value}');
      if (feedback != null) {
        result = MonthlyTransactionModel.fromJson(feedback);
        respStatus.value = result.statusCode;
      } else {}
    } finally {
      if (respStatus.value == 200) {
        transactions.clear();
        isLoading.value = false;
        transactions.value = result.data.data;
        developer.log('transactions: ${transactions[0].id}');
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
}
