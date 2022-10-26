import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:gym/controller/home_controller.dart';
import 'package:gym/controller/member_screen_controller.dart';
import 'package:gym/utils/constants/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

class MemberScreen {
  final HomeController homeController = Get.put(HomeController());
  final memberScreenController = Get.put(MemberScreenController());

  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  final List<String> statusItems = [
    'Active',
    'Inactive',
  ];

  String? selectedValue;
  Widget body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Members',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: !homeController.isSearching.value,
                    child: _buildIconTile(
                        icon: Icons.calendar_month_rounded,
                        title: 'Date',
                        onTap: () {
                          homeController.pickDateRange(context);
                        }),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Obx(
                  () => Visibility(
                    visible: !homeController.isSearching.value,
                    child: SizedBox(
                      width: 80,
                      child: DropdownButtonFormField2(
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.grey,
                                width: 0.3,
                              ),
                            ),
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.grey,
                                width: 0.3,
                              ),
                            )),
                        isExpanded: true,
                        hint: const Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.grey,
                        ),
                        iconSize: 20,
                        // buttonHeight: 60,
                        buttonWidth: 80,
                        buttonPadding: EdgeInsets.symmetric(horizontal: 5),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.grey, width: 0.3),
                        ),
                        items: genderItems
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          //Do something when changing the item if you want.
                        },
                        onSaved: (value) {
                          selectedValue = value.toString();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Obx(
                  () => Visibility(
                    visible: !homeController.isSearching.value,
                    child: SizedBox(
                      width: 90,
                      child: DropdownButtonFormField2(
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.grey,
                                width: 0.3,
                              ),
                            ),
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.grey,
                                width: 0.3,
                              ),
                            )),
                        isExpanded: true,
                        hint: const Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.grey,
                        ),
                        iconSize: 20,
                        // buttonHeight: 60,
                        buttonWidth: 90,
                        buttonPadding: EdgeInsets.symmetric(horizontal: 5),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.grey, width: 0.3),
                        ),
                        items: statusItems
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          //Do something when changing the item if you want.
                        },
                        onSaved: (value) {
                          selectedValue = value.toString();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: TextField(
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                  onTap: () => homeController.toggleSearch(),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColors.grey,
                        width: 0.3,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.search,
                        size: 10,
                        color: AppColors.grey,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.grey,
                        width: 0.3,
                      ),
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 20,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          index.isEven
                              ? 'assets/images/female_head.png'
                              : 'assets/images/male_head.png',
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: _buildListTileText(
                              head: 'Salman Salim',
                              body: 'Njaveliparambil House, Kottayam , Kerala'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: _buildListTileText(
                              head: '8590385573', body: 'Monthly Premium plus'),
                        ),
                        _buildIconTile(
                            icon: Icons.person, title: 'Details', onTap: () {}),
                        SizedBox(
                          width: 10,
                        ),
                        _buildIconTile(
                            icon: Icons.payment_rounded,
                            title: 'Transactions',
                            onTap: () {}),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 90,
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.grey,
                                    width: 0.3,
                                  ),
                                ),
                                fillColor: index.isEven
                                    ? Colors.red.shade700.withOpacity(0.2)
                                    : Colors.green.shade700.withOpacity(0.2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.grey,
                                    width: 0.3,
                                  ),
                                )),
                            isExpanded: true,
                            hint: const Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.grey,
                            ),
                            iconSize: 20,
                            // buttonHeight: 60,
                            buttonWidth: 90,
                            buttonPadding: EdgeInsets.symmetric(horizontal: 5),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: AppColors.grey, width: 0.3),
                            ),
                            items: statusItems
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildIconTile(
                      icon: Icons.skip_previous,
                      title: 'Previous',
                      onTap: () {}),
                  SizedBox(
                    width: 10,
                  ),
                  _buildIconTileRight(
                      icon: Icons.skip_next, title: 'Next', onTap: () {}),
                  SizedBox(
                    width: 10,
                  ),
                  _buildIconTile(
                      icon: Icons.add_circle_outline_outlined,
                      title: 'Add Member',
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Member Registration',
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: AppColors.grey,
                                              width: 0.3),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: AppColors.black,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.grey.withOpacity(0.3),
                                content: Container(
                                    width: size.width * 0.5,
                                    height: size.height * 0.7,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              _buildTextField(
                                                controller:
                                                    TextEditingController(),
                                                hint: 'Name',
                                                textInputType:
                                                    TextInputType.text,
                                                onChanged: (value) =>
                                                    memberScreenController
                                                        .getName(value),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              _buildTextField(
                                                controller:
                                                    TextEditingController(),
                                                hint: 'Mobile number',
                                                onChanged: (value) =>
                                                    memberScreenController
                                                        .getMobile(value),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: DropdownButtonFormField2(
                                                  decoration:
                                                      _dropDownDecocration(),
                                                  isExpanded: true,
                                                  hint: const Text(
                                                    'Gender',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.grey,
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: AppColors.grey,
                                                  ),
                                                  iconSize: 20,
                                                  // buttonHeight: 60,
                                                  buttonWidth: 90,
                                                  buttonPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5),
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColors.grey,
                                                        width: 0.3),
                                                  ),
                                                  items: genderItems
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    memberScreenController
                                                        .setGender(
                                                            value.toString());
                                                  },
                                                  onSaved: (value) {
                                                    selectedValue =
                                                        value.toString();
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              _buildTextField(
                                                controller:
                                                    TextEditingController(),
                                                hint: 'Job',
                                                textInputType:
                                                    TextInputType.text,
                                                onChanged: (value) =>
                                                    memberScreenController
                                                        .getJob(value),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              _buildTextField(
                                                controller:
                                                    TextEditingController(),
                                                hint: 'Pincode',
                                                onChanged: (value) =>
                                                    memberScreenController
                                                        .getPincode(value),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Obx(
                                                () => _buildTextField(
                                                  controller: TextEditingController(
                                                      text:
                                                          memberScreenController
                                                              .state.value),
                                                  hint: 'State',
                                                  isReadOnly: true,
                                                  onChanged: (value) =>
                                                      print(value),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Obx(
                                                () => _buildTextField(
                                                  controller: TextEditingController(
                                                      text:
                                                          memberScreenController
                                                              .district.value),
                                                  hint: 'District',
                                                  isReadOnly: true,
                                                  onChanged: (value) =>
                                                      print(value),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Obx(() =>
                                                    DropdownButtonFormField2(
                                                      decoration:
                                                          _dropDownDecocration(),
                                                      isExpanded: true,
                                                      hint: const Text(
                                                        'Area',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppColors.grey,
                                                        ),
                                                      ),
                                                      icon: const Icon(
                                                        Icons.arrow_drop_down,
                                                        color: AppColors.grey,
                                                      ),
                                                      iconSize: 20,
                                                      // buttonHeight: 60,
                                                      buttonWidth: 90,
                                                      buttonPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      dropdownDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color:
                                                                AppColors.grey,
                                                            width: 0.3),
                                                      ),
                                                      items: memberScreenController
                                                          .areas.value
                                                          .map((item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                  ),
                                                                ),
                                                              ))
                                                          .toList(),
                                                      onChanged: (value) {
                                                        memberScreenController
                                                            .setArea(value
                                                                .toString());
                                                      },
                                                      onSaved: (value) {
                                                        selectedValue =
                                                            value.toString();
                                                      },
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildTextField(
                                                controller:
                                                    TextEditingController(),
                                                hint: 'Address',
                                                textInputType:
                                                    TextInputType.text,
                                                onChanged: (value) =>
                                                    memberScreenController
                                                        .getAddress(value),
                                                lines: 4,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        _buildTextField(
                                                          controller:
                                                              TextEditingController(),
                                                          hint: 'Weight',
                                                          onChanged: (value) =>
                                                              memberScreenController
                                                                  .getWeight(
                                                                      value),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        _buildTextField(
                                                          controller:
                                                              TextEditingController(),
                                                          hint: 'Height',
                                                          onChanged: (value) =>
                                                              memberScreenController
                                                                  .getHeight(
                                                                      value),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        _buildTextField(
                                                          controller:
                                                              TextEditingController(),
                                                          hint: 'Age',
                                                          onChanged: (value) =>
                                                              memberScreenController
                                                                  .getAge(
                                                                      value),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Obx(
                                                          () => _buildTextField(
                                                            controller:
                                                                TextEditingController(
                                                                    text: memberScreenController
                                                                        .score
                                                                        .value),
                                                            hint: 'Scroe',
                                                            isReadOnly: true,
                                                            onChanged:
                                                                (value) =>
                                                                    print(
                                                                        value),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              _buildTextFieldDate(
                                                  hint: 'Joining Date',
                                                  context: context),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              _buildTextFieldDate(
                                                  hint: 'Reminder Date',
                                                  context: context),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              _buildTextField(
                                                controller:
                                                    TextEditingController(),
                                                hint: 'Aadhaar number',
                                                onChanged: (value) =>
                                                    memberScreenController
                                                        .getAdhaar(value),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: DropdownButtonFormField2(
                                                  decoration:
                                                      _dropDownDecocration(),
                                                  isExpanded: true,
                                                  hint: const Text(
                                                    'Package',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.grey,
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: AppColors.grey,
                                                  ),
                                                  iconSize: 20,
                                                  // buttonHeight: 60,
                                                  buttonWidth: 90,
                                                  buttonPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                  ),
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColors.grey,
                                                        width: 0.3),
                                                  ),
                                                  items: genderItems
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    //Do something when changing the item if you want.
                                                  },
                                                  onSaved: (value) {
                                                    selectedValue =
                                                        value.toString();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              _buildTextField(
                                                controller:
                                                    TextEditingController(),
                                                hint: 'Registration Fee',
                                                onChanged: (value) =>
                                                    memberScreenController
                                                        .getRegistrationFee(
                                                            value),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0.3),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Register',
                                                      style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '© 2022 ERE Business Solutions Pvt. Ltd',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _dropDownDecocration() {
    return InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: 0.3,
          ),
        ),
        fillColor: Colors.grey.withOpacity(0.2),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: 0.3,
          ),
        ));
  }

  Flexible _buildTextField(
      {required String hint,
      required Function(String value) onChanged,
      int lines = 1,
      bool isReadOnly = false,
      TextInputType textInputType = TextInputType.number,
      required TextEditingController controller}) {
    return Flexible(
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 12,
        ),
        maxLines: lines,
        keyboardType: textInputType,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          isCollapsed: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontSize: 12,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.grey,
              width: 0.3,
            ),
          ),
          fillColor: Colors.grey.withOpacity(0.2),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.grey,
              width: 0.3,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Flexible _buildTextFieldDate(
      {required String hint, int lines = 1, required BuildContext context}) {
    return Flexible(
      child: TextField(
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 12,
        ),
        readOnly: true,
        maxLines: lines,
        decoration: InputDecoration(
          isCollapsed: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontSize: 12,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.grey,
              width: 0.3,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.calendar_today,
              size: 15,
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 20,
          ),
          fillColor: Colors.grey.withOpacity(0.2),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.grey,
              width: 0.3,
            ),
          ),
        ),
        onTap: () {
          homeController.selectDate(context);
        },
      ),
    );
  }
// CUstom Widget

  Widget _buildIconTile(
      {required IconData icon,
      required String title,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey, width: 0.3),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15,
              color: AppColors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text(title,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildIconTileRight(
      {required IconData icon,
      required String title,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey, width: 0.3),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                )),
            SizedBox(
              width: 5,
            ),
            Icon(
              icon,
              size: 15,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Column _buildListTileText({required String head, required String body}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          body,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 9,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
