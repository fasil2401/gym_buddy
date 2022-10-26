import 'package:get/get.dart';
import 'package:gym/model/package_model.dart';
import 'package:gym/model/postal_area_model.dart';
import 'package:gym/services/api_services.dart';

class MemberScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getPackages();
  }

  var isLoading = false.obs;
  var respStatus = 0.obs;
  var respMessage = ''.obs;
  var searchQuery = ''.obs;
  var gender = ''.obs;
  var status = false.obs;
  var fromDate = ''.obs;
  var toDate = ''.obs;
  var page = 1.obs;
  var pincode = ''.obs;
  var district = ''.obs;
  var state = ''.obs;
  var areas = [].obs;
  var packages = [].obs;
  var members = [].obs;
  var name = ''.obs;
  var mobile = ''.obs;
  var job = ''.obs;
  var joiningDate = ''.obs;
  var remiderDate = ''.obs;
  var registrationFee = ''.obs;
  var address = ''.obs;
  var height = ''.obs;
  var weight = ''.obs;
  var age = ''.obs;
  var score = ''.obs;
  var adhaar = ''.obs;
  var area = ''.obs;

  changeStatus(String value) {
    status.value = value == 'Active' ? true : false;
  }

  getName(String name) {
    this.name.value = name;
    print(this.name.value);
  }

  getMobile(String mobile) {
    this.mobile.value = mobile;
    print(this.mobile.value);
  }

  getJob(String job) {
    this.job.value = job;
    print(this.job.value);
  }

  getRegistrationFee(String registrationFee) {
    this.registrationFee.value = registrationFee;
    print(this.registrationFee.value);
  }

  getAddress(String address) {
    this.address.value = address;
    print(this.address.value);
  }

  getHeight(String height) {
    this.height.value = height;
    print(this.height.value);
  }

  getWeight(String weight) {
    this.weight.value = weight;
    print(this.weight.value);
  }

  getAge(String age) {
    this.age.value = age;
    print(this.age.value);
  }

  getAdhaar(String adhaar) {
    this.adhaar.value = adhaar;
    print(this.adhaar.value);
  }

  setArea(String area) {
    this.area.value = area;
    print(this.area.value);
  }

  setGender(String gender) {
    this.gender.value = gender;
    print(this.gender.value);
  }

  getPincode(String pin) async {
    this.pincode.value = pin;
    if (pincode.value.length == 6 && isLoading.value == false) {
      isLoading.value = true;

      var result;
      try {
        var feedback = await ApiManager.fetchPincodeGet(
            api: 'https://api.postalpincode.in/pincode/${pincode.value}');
        if (feedback != null) {
          result = PinCodeModel.fromJson(feedback[0]);
          respMessage.value = result.status;
          print(respMessage.value);
        } else {}
      } finally {
        if (respMessage.value == 'Success') {
          state.value = result.postOffice[0].state;
          district.value = result.postOffice[0].district;
          for (var area in result.postOffice) {
            areas.add(area.name);
          }
          print(areas);
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      }
    }
  }

  getPackages() async {
    isLoading.value = true;
    var result;
    try {
      var feedback = await ApiManager.fetchDataGet(api: 'config');
      if (feedback != null) {
        result = PackageModel.fromJson(feedback);
        respStatus.value = result.statusCode;
        print(respStatus.value);
      } else {}
    } finally {
      if (respStatus.value == 200) {
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }
}
