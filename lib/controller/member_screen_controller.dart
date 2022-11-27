import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym/controller/image_controller.dart';
import 'package:gym/model/customer_list_model.dart' as customer;
import 'package:gym/model/images_model.dart';
import 'package:gym/model/member_model.dart';
import 'package:gym/model/package_model.dart';
import 'package:gym/model/postal_area_model.dart';
import 'package:gym/model/register_error_model.dart';
import 'package:gym/model/register_model.dart';
import 'package:gym/model/update_member_model.dart';
import 'package:gym/services/api_services.dart';
import 'package:gym/utils/date_formatter.dart';

class MemberScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getPackages();
    getMenbers();
  }

  final imagesController = Get.put(ImagesController());
  var pageSizes = 15.obs;
  var pageNumber = 1.obs;
  var query = ''.obs;
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
  var packageId = ''.obs;
  var mobileError = false.obs;
  var fieldError = false.obs;

  removeFIlter() {
    dateFrom.value = DateTime(2000).toString();
    dateTo.value = DateTime.now().toString();
    filterStatus.value = '';
    filterGender.value = '';
    getMenbers();
  }

  changeStatus(String value, MemberModel member, BuildContext context) async {
    status.value = value == 'Active' ? true : false;
    print(status.value);
    await setFieldValues(member);
    updateMember(context, member.id, false);
  }

  setFilterStatus(String value) {
    value == 'Active'
        ? filterStatus.value = 'true'
        : filterStatus.value = 'false';
    getMenbers();
  }

  setFilterGender(String gender) {
    filterGender.value = gender;
    getMenbers();
  }

  getQuery(String value) {
    query.value = value;
    print(query.value);
    getMenbers();
  }

  nextPage() {
    pageNumber.value++;
    getMenbers();
  }

  previousPage() {
    if (pageNumber.value > 1) {
      pageNumber.value--;
      getMenbers();
    }
  }

  getBmi() {
    if (height.value != '' && weight.value != '') {
      var h = double.parse(height.value);
      var w = double.parse(weight.value);
      var bmi = (w / (h * h)) * 10000;
      score.value = bmi.toStringAsFixed(2);
      print(score.value);
    }
  }

  getName(String name) {
    this.name.value = name;
    print(this.name.value);
  }

  getMobile(String mobile) {
    this.mobile.value = mobile;
    mobileError.value = false;
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
    getBmi();
    print(this.height.value);
  }

  getWeight(String weight) {
    this.weight.value = weight;
    getBmi();
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

  setPackage(String packageId) {
    this.packageId.value = packageId;
    print(this.packageId.value);
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
    dateFrom.value = dateFormat.format(dateTime.start).toString();
    dateTo.value = dateFormat.format(dateTime.end).toString();
    print(dateFrom.value);
    print(dateTo.value);
    getMenbers();
  }

  selectDate(context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      joiningDate.value = dateFormat.format(newDate).toString();
      print(joiningDate.value);
    }

    update();
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
          areas.clear();
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
      var feedback = await ApiManager.fetchDataGet(api: 'packages');
      if (feedback != null) {
        result = PackageModel.fromJson(feedback);
        respStatus.value = result.statusCode;
        print(respStatus.value);
      } else {}
    } finally {
      if (respStatus.value == 200) {
        for (var package in result.packages) {
          if (package.status == true) {
            packages.add(package);
          }
        }
        print(packages);
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  registerCustomer(BuildContext context) async {
    if (name.value != '' &&
        mobile.value != '' &&
        job.value != '' &&
        gender.value != '' &&
        address.value != '' &&
        height.value != '' &&
        weight.value != '' &&
        age.value != '' &&
        adhaar.value != '' &&
        area.value != '' &&
        packageId.value != '' &&
        joiningDate.value != '') {
      final data = json.encode({
        "name": name.value,
        "mobile": mobile.value,
        "gender": gender.value,
        "job": job.value,
        "pincode": pincode.value,
        "state": state.value,
        "district": district.value,
        "area": area.value,
        "address": address.value,
        "weight": double.parse(weight.value),
        "height": double.parse(height.value),
        "age": int.parse(age.value),
        "score": double.parse(score.value),
        "joiningDate": joiningDate.value,
        "aadhaar": adhaar.value,
        "package": packageId.value,
        "status": true
      });
      print(data);
      isLoading.value = true;
      var result;
      try {
        var feedback =
            await ApiManager.fetchDataRawBody(api: 'customers', data: data);
        if (feedback != null && feedback['statusCode'] == 200) {
          result = RegisterModel.fromJson(feedback);
          respStatus.value = result.statusCode;
          print(respStatus.value);
        } else {
          result = RegisterErrorModel.fromJson(feedback);
          respStatus.value = result.statusCode;
          print(respStatus.value);
        }
      } finally {
        if (respStatus.value == 200) {
          imagesController.createImage(
              image: ImageModel(
                  id: mobile.value.toString(),
                  image: imagesController.base64string.value.toString()));
          isLoading.value = false;
          resetFieldValues();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Customer Registered Successfully"),
          ));
          getMenbers();
        } else {
          isLoading.value = false;
          mobileError.value = true;
        }
      }
    } else {
      fieldError.value = true;
    }
  }

  getMenbers() async {
    isLoading.value = true;
    var result;
    try {
      var feedback = await ApiManager.fetchDataGet(
          api:
              'customers?page=${pageNumber.value.toString()}&pageSize=${pageSizes.value.toString()}&query=${query.value}&gender=${filterGender.value}&status=${filterStatus.value}&from=${dateFrom.value}&to=${dateTo.value}');
      if (feedback != null) {
        result = feedback['data']['customers'];
        print(result.runtimeType);
        members.clear();
        for (var member in result) {
          members.add(MemberModel(
            id: member['_id'].toString(),
            name: member['name'].toString(),
            mobile: member['mobile'].toString(),
            gender: member['gender'].toString(),
            job: member['job'].toString(),
            pincode: member['pincode'].toString(),
            state: member['state'].toString(),
            district: member['district'].toString(),
            area: member['area'].toString(),
            address: member['address'].toString(),
            weight: member['weight'],
            height: member['height'],
            age: member['age'],
            score: member['score'],
            joiningDate: member['joiningDate'].toString(),
            aadhaar: member['aadhaar'],
            package: member['package']['_id'],
            packageName: member['package']['name'],
            status: member['status'],
          ));
        }
      } else {}
    } finally {
      if (respStatus.value == 200) {
        // members.clear();
        isLoading.value = false;
        // members.value = result.data.customers;
        // print(members);
      } else {
        isLoading.value = false;
      }
    }
  }

  updateMember(BuildContext context, String id, bool isEditing) async {
    print('id is $id');
    final data = json.encode({
      "name": name.value,
      "mobile": mobile.value,
      "gender": gender.value,
      "job": job.value,
      "pincode": pincode.value,
      "state": state.value,
      "district": district.value,
      "area": area.value,
      "address": address.value,
      "weight": double.parse(weight.value),
      "height": double.parse(height.value),
      "age": int.parse(age.value),
      "score": double.parse(score.value),
      "joiningDate": joiningDate.value.toString(),
      "aadhaar": adhaar.value,
      "package": packageId.value,
      "status": status.value
    });

    print(data);
    isLoading.value = true;
    var result;
    try {
      var feedback =
          await ApiManager.patchDataRawBody(api: 'customers/${id}', data: data);
      if (feedback != null && feedback['statusCode'] == 200) {
        result = UpdateMemberModel.fromJson(feedback);
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
        // Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Customer Updated Successfully"),
        ));
        getMenbers();
        if (isEditing) {
          Navigator.of(context).pop();
        }
      } else {
        isLoading.value = false;
        mobileError.value = true;
      }
    }
  }

  setFieldValues(MemberModel menber) async {
    name.value = menber.name;
    mobile.value = menber.mobile;
    gender.value = menber.gender;
    job.value = menber.job;
    pincode.value = menber.pincode;
    state.value = menber.state;
    district.value = menber.district;
    area.value = menber.area;
    address.value = menber.address;
    weight.value = menber.weight.toString();
    height.value = menber.height.toString();
    age.value = menber.age.toString();
    score.value = menber.score.toString();
    joiningDate.value = menber.joiningDate.toString();
    adhaar.value = menber.aadhaar;
    packageId.value = menber.package;
    status.value = status.value;
    imagesController.getImage(menber);
  }

  resetFieldValues() {
    imagesController.base64string.value = '';
    name.value = '';
    mobile.value = '';
    gender.value = '';
    job.value = '';
    pincode.value = '';
    state.value = '';
    district.value = '';
    area.value = '';
    address.value = '';
    weight.value = '';
    height.value = '';
    age.value = '';
    adhaar.value = '';
    packageId.value = '';
    joiningDate.value = '';
    registrationFee.value = '';
    fieldError.value = false;
  }
}
