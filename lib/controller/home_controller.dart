import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isSearching = false.obs;

  void toggleSearch() {
    isSearching.value = !isSearching.value;
  }

  pickDateRange(BuildContext context) async {
    DateTimeRange dateTime =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDateRange: dateTime);

    if (newDateRange == null) return;

    dateTime = newDateRange;
    print(dateTime.start);
    print(dateTime.end);
  }

  selectDate(context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {}

    update();
  }
}
