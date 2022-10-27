import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  // var dateFrom = DateTime(2000).toString().obs;
  var dateToCheck = ''.obs;
  var filterStatus = ''.obs;

  var isLoading = false.obs;
  var respStatus = 0.obs;
  var respMessage = ''.obs;
  var transactions = [].obs;
  var transaction = TransactionByIdModel().obs;
  var searchQuery = ''.obs;
  var gender = ''.obs;
  var status = true.obs;

  setFilterStatus(String value) {
    value == 'Active'
        ? filterStatus.value = 'true'
        : filterStatus.value = 'false';

    getTransactions();
  }

  nextPage() {
    pageNumber.value++;
    getTransactions();
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
}
