import 'package:get/get.dart';

class TransactionScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var pageSizes = 15.obs;
  var pageNumber = 1.obs;
  var dateFrom = DateTime(2000).toString().obs;
  var dateTo = DateTime.now().toString().obs;
  var filterStatus = ''.obs;
  var filterGender = ''.obs;

  var isLoading = false.obs;
  var respStatus = 0.obs;
  var respMessage = ''.obs;
  var searchQuery = ''.obs;
  var gender = ''.obs;
  var status = true.obs;
  var page = 1.obs;
  var pincode = ''.obs;
  var district = ''.obs;
  var state = ''.obs;

}
