import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:gym/controller/home_controller.dart';
import 'package:gym/controller/member_screen_controller.dart';
import 'package:gym/controller/transaction_screen_controller.dart';
import 'package:gym/utils/constants/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:gym/utils/date_formatter.dart';
import 'package:gym/view/components/transaction_screen.dart';

class MemberScreen {
  final HomeController homeController = Get.put(HomeController());
  final memberScreenController = Get.put(MemberScreenController());
  final transactionScreenController = Get.put(TransactionScreenController());

  final List<String> genderItems = [
    'male',
    'female',
  ];
  final List<String> statusItems = [
    'Active',
    'Inactive',
  ];

  var selectedValue;
  Widget body(Size size, BuildContext context) {
    return Obx(() => homeController.isTransaction.value
        ? Container(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            homeController.switchTransaction(false);
                          },
                          icon:
                              Icon(Icons.arrow_back_ios, color: Colors.white)),
                      Expanded(
                        child: Obx(() => Text(
                              'Transactions of ${transactionScreenController.customerName.value}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child:
                        Obx(
                            () =>
                                transactionScreenController
                                        .userTransactions.isEmpty
                                    ? Center(
                                        child: transactionScreenController
                                                .isLoading.value
                                            ? CircularProgressIndicator(
                                                color: AppColors.white,
                                              )
                                            : Text('No data found',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize: 20,
                                                )))
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: transactionScreenController
                                            .userTransactions.length,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var transaction =
                                              transactionScreenController
                                                  .userTransactions[index];
                                          return Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 14),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: _buildListTileText(
                                                      head: transaction.trxId,
                                                      body:
                                                          'on ${dateFormat.format(transaction.date).toString()}'),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    transaction.package.name,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    transaction.notes,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '₹ ${transaction.amount}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                _buildIconTile(
                                                    icon: Icons.person,
                                                    title: 'Details',
                                                    onTap: () {
                                                      transactionScreenController
                                                          .getTransactionById(
                                                              transaction.id);
                                                      showDialog<void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 10,
                                                                    sigmaY: 10),
                                                            child: AlertDialog(
                                                                title: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Text(
                                                                        'Transactions Details',
                                                                        style: TextStyle(
                                                                            color: AppColors
                                                                                .white,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          border: Border.all(
                                                                              color: AppColors.grey,
                                                                              width: 0.3),
                                                                        ),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              AppColors.black,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                backgroundColor:
                                                                    Colors.grey
                                                                        .withOpacity(
                                                                            0.3),
                                                                content: Obx(
                                                                  () => Container(
                                                                      width: 400,
                                                                      height: size.height * 0.5,
                                                                      child: SingleChildScrollView(
                                                                        child: transactionScreenController.isLoading.value
                                                                            ? Center(
                                                                                child: CircularProgressIndicator(
                                                                                color: AppColors.white,
                                                                              ))
                                                                            : Column(
                                                                                children: [
                                                                                  Card(
                                                                                    color: AppColors.glass,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          _buildTransDetailText(title: 'Transaction ID', value: transactionScreenController.transaction.value.data!.trxId),
                                                                                          _buildTransDetailTextRight(title: 'Payment Mode', value: 'Gpay/Cash'),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Card(
                                                                                    color: AppColors.glass,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          _buildTransDetailText(title: 'Customer Name', value: transactionScreenController.transaction.value.data!.customer.name),
                                                                                          Text(
                                                                                            'GS654',
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Card(
                                                                                    color: AppColors.glass,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          _buildTransDetailText(title: 'Package', value: transaction.package.name),
                                                                                          Text(
                                                                                            'Rs. ${transaction.package.price}',
                                                                                            textAlign: TextAlign.center,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Card(
                                                                                    color: AppColors.glass,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          _buildTransDetailText(title: 'Transaction Note', value: transactionScreenController.transaction.value.data!.notes),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Card(
                                                                                          color: AppColors.glass,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                _buildTransDetailText(title: 'Transaction Date', value: '${dateFormat.format(transactionScreenController.transaction.value.data!.date)}'),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Card(
                                                                                          color: AppColors.glass,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                _buildTransDetailText(title: 'Transaction Amount', value: 'Rs. ${transactionScreenController.transaction.value.data!.amount}'),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                      )),
                                                                )),
                                                          );
                                                        },
                                                      );
                                                    }),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 5,
                                        ),
                                      )),
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
                            onTap: () {
                              transactionScreenController.previousUserPage();
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(() => Text(
                              '${transactionScreenController.customerPageNumber.value}',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        _buildIconTileRight(
                            icon: Icons.skip_next,
                            title: 'Next',
                            onTap: () {
                              transactionScreenController.nextUserPage();
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        _buildIconTile(
                            icon: Icons.add_circle_outline_outlined,
                            title: 'Add Transactions',
                            onTap: () {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Add Transaction to ${transactionScreenController.customerName.value}',
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
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.3),
                                      content: Container(
                                          width: size.width * 0.5,
                                          height: size.height * 0.4,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Obx(() => Visibility(
                                                      visible:
                                                          transactionScreenController
                                                              .fieldError.value,
                                                      child: Text(
                                                        '**Please fill all the fields',
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.red,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    )),
                                                Row(
                                                  children: [
                                                    TransactionScreen.buildTextField(
                                                        hint: 'Transaction Fee',
                                                        onChanged: (value) =>
                                                            transactionScreenController
                                                                .getTransactionFee(
                                                                    value)),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Obx(
                                                      () =>
                                                          _buildTextFieldTransDate(
                                                        hint:
                                                            'Transaction Date',
                                                        context: context,
                                                        controller:
                                                            TextEditingController(
                                                          text: dateFormat
                                                              .format(transactionScreenController
                                                                  .transactionDate
                                                                  .value)
                                                              .toString(),
                                                        ),
                                                      ),
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
                                                    TransactionScreen
                                                        .buildTextField(
                                                      hint: 'Transaction Note',
                                                      onChanged: (value) =>
                                                          transactionScreenController
                                                              .getTrabsactionNote(
                                                                  value),
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
                                                              Flexible(
                                                                child: Obx(
                                                                  () =>
                                                                      DropdownButtonFormField2(
                                                                    decoration:
                                                                        _dropDownDecocration(),
                                                                    isExpanded:
                                                                        true,
                                                                    hint:
                                                                        const Text(
                                                                      'Package',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: AppColors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      color: AppColors
                                                                          .grey,
                                                                    ),
                                                                    iconSize:
                                                                        20,
                                                                    // buttonHeight: 60,
                                                                    buttonWidth:
                                                                        90,
                                                                    buttonPadding:
                                                                        EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                5),
                                                                    dropdownDecoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color: AppColors
                                                                              .grey,
                                                                          width:
                                                                              0.3),
                                                                    ),
                                                                    items: memberScreenController
                                                                        .packages
                                                                        .map((item) =>
                                                                            DropdownMenuItem(
                                                                              value: item,
                                                                              child: Text(
                                                                                item.name,
                                                                                style: const TextStyle(
                                                                                  fontSize: 12,
                                                                                  color: AppColors.grey,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                    onChanged:
                                                                        (value) {
                                                                      selectedValue =
                                                                          value;
                                                                      transactionScreenController.getPackageAmount(selectedValue
                                                                          .price
                                                                          .toString());
                                                                      transactionScreenController.getPackage(
                                                                          selectedValue
                                                                              .id
                                                                              .toString());
                                                                    },
                                                                    onSaved:
                                                                        (value) {
                                                                      selectedValue =
                                                                          value
                                                                              .toString();
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Obx(
                                                                () =>
                                                                    _buildTextField(
                                                                  controller: TextEditingController(
                                                                      text: transactionScreenController
                                                                          .packageAmount
                                                                          .value
                                                                          .toString()),
                                                                  hint:
                                                                      'Package Amount',
                                                                  isReadOnly:
                                                                      true,
                                                                  onChanged:
                                                                      (value) =>
                                                                          print(
                                                                              value),
                                                                ),
                                                              ),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () =>
                                                          transactionScreenController
                                                              .createTransaction(
                                                                  context),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 0.3),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        8),
                                                            child: Text(
                                                              'Add',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
          )
        : Container(
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
                                memberScreenController.pickDateRange(context);
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
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
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
                              buttonPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.grey, width: 0.3),
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
                                memberScreenController
                                    .setFilterGender(value.toString());
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
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
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
                              buttonPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.grey, width: 0.3),
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
                                memberScreenController
                                    .setFilterStatus(value.toString());
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
                        // onChanged: (value) {
                        //   memberScreenController.getQuery(value);
                        // },
                        onSubmitted: (value) =>
                            memberScreenController.getQuery(value),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                    child: Obx(() => memberScreenController.members.isEmpty
                        ? Center(
                            child: memberScreenController.isLoading.value
                                ? CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                : Text('No data found',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 20,
                                    )))
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount: memberScreenController.members.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var member =
                                  memberScreenController.members[index];
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      member.gender == 'female'
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
                                          head: member.name,
                                          body:
                                              '${member.area}, ${member.district}, ${member.state}'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: _buildListTileText(
                                          head: member.mobile,
                                          body: member.packageName),
                                    ),
                                    _buildIconTile(
                                        icon: Icons.person,
                                        title: 'Details',
                                        onTap: () async {
                                          await memberScreenController
                                              .setFieldValues(member);
                                          _buildDetailDialog(context, size,
                                              member.packageName, member.id);
                                        }),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    _buildIconTile(
                                        icon: Icons.payment_rounded,
                                        title: 'Transactions',
                                        onTap: () {
                                          transactionScreenController
                                              .customerPageNumber.value = 1;
                                          transactionScreenController
                                              .getUserTransactions(
                                                  member.id, member.name);
                                          homeController
                                              .switchTransaction(true);
                                        }),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                        width: 90,
                                        child: DropdownButtonFormField2(
                                          decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: AppColors.grey,
                                                  width: 0.3,
                                                ),
                                              ),
                                              fillColor: !member.status
                                                  ? Colors.red.shade700
                                                      .withOpacity(0.2)
                                                  : Colors.green.shade700
                                                      .withOpacity(0.2),
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                  color: AppColors.grey,
                                                  width: 0.3,
                                                ),
                                              )),
                                          isExpanded: true,
                                          hint: Text(
                                            member.status
                                                ? 'Active'
                                                : 'Inactive',
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
                                          buttonPadding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.grey,
                                                width: 0.3),
                                          ),
                                          items: statusItems
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
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
                                            memberScreenController.changeStatus(
                                                value.toString(),
                                                member,
                                                context);
                                          },
                                          onSaved: (value) {
                                            selectedValue = value.toString();
                                          },
                                        )),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 5,
                            ),
                          )),
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
                            onTap: () {
                              memberScreenController.previousPage();
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(() => Text(
                              '${memberScreenController.pageNumber.value}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.grey,
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        _buildIconTileRight(
                            icon: Icons.skip_next,
                            title: 'Next',
                            onTap: () {
                              memberScreenController.nextPage();
                            }),
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
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
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
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.3),
                                      content: Container(
                                          width: size.width * 0.5,
                                          height: size.height * 0.7,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Obx(() => Visibility(
                                                      visible:
                                                          memberScreenController
                                                              .fieldError.value,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            '**Please fill all the fields',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .red,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
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
                                                  height: 5,
                                                ),
                                                Obx(() => Visibility(
                                                      visible:
                                                          memberScreenController
                                                              .mobileError
                                                              .value,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                            'Mobile number Already Exist',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .red,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child:
                                                          DropdownButtonFormField2(
                                                        decoration:
                                                            _dropDownDecocration(),
                                                        isExpanded: true,
                                                        hint: const Text(
                                                          'Gender',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                AppColors.grey,
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
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5),
                                                        dropdownDecoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .grey,
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
                                                                      fontSize:
                                                                          12,
                                                                      color: AppColors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ))
                                                            .toList(),
                                                        onChanged: (value) {
                                                          memberScreenController
                                                              .setGender(value
                                                                  .toString());
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
                                                              .getPincode(
                                                                  value),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Obx(
                                                      () => _buildTextField(
                                                        controller:
                                                            TextEditingController(
                                                                text:
                                                                    memberScreenController
                                                                        .state
                                                                        .value),
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
                                                        controller:
                                                            TextEditingController(
                                                                text:
                                                                    memberScreenController
                                                                        .district
                                                                        .value),
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
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                            ),
                                                            icon: const Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color: AppColors
                                                                  .grey,
                                                            ),
                                                            iconSize: 20,
                                                            // buttonHeight: 60,
                                                            buttonWidth: 90,
                                                            buttonPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5),
                                                            dropdownDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                  width: 0.3),
                                                            ),
                                                            items: memberScreenController
                                                                .areas.value
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child:
                                                                          Text(
                                                                        item,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              AppColors.grey,
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
                                                                  value
                                                                      .toString();
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
                                                              .getAddress(
                                                                  value),
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
                                                                () =>
                                                                    _buildTextField(
                                                                  controller:
                                                                      TextEditingController(
                                                                          text:
                                                                              'BMI : ${memberScreenController.score.value}'),
                                                                  hint: 'Scroe',
                                                                  isReadOnly:
                                                                      true,
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
                                                    Obx(
                                                      () => _buildTextFieldDate(
                                                          controller:
                                                              TextEditingController(
                                                                  text: memberScreenController
                                                                      .joiningDate
                                                                      .value),
                                                          hint: 'Joining Date',
                                                          context: context),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    _buildTextField(
                                                      controller:
                                                          TextEditingController(),
                                                      hint: 'Aadhaar number',
                                                      onChanged: (value) =>
                                                          memberScreenController
                                                              .getAdhaar(value),
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
                                                      child: Obx(() =>
                                                          DropdownButtonFormField2(
                                                            decoration:
                                                                _dropDownDecocration(),
                                                            isExpanded: true,
                                                            hint: const Text(
                                                              'Package',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                            ),
                                                            icon: const Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color: AppColors
                                                                  .grey,
                                                            ),
                                                            iconSize: 20,
                                                            // buttonHeight: 60,
                                                            buttonWidth: 90,
                                                            buttonPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 5,
                                                            ),
                                                            dropdownDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                  width: 0.3),
                                                            ),
                                                            items: memberScreenController
                                                                .packages
                                                                .map((item) =>
                                                                    DropdownMenuItem(
                                                                      value:
                                                                          item,
                                                                      child:
                                                                          Text(
                                                                        item.name,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              AppColors.grey,
                                                                        ),
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                            onChanged: (value) {
                                                              selectedValue =
                                                                  value;
                                                              memberScreenController
                                                                  .setPackage(
                                                                      selectedValue
                                                                          .id
                                                                          .toString());
                                                            },
                                                            onSaved: (value) {
                                                              selectedValue =
                                                                  value
                                                                      .toString();
                                                            },
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                        child: InkWell(
                                                      onTap: () {
                                                        memberScreenController
                                                            .registerCustomer(
                                                                context);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 0.3),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'Register',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
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
          ));
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
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
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
      {required String hint,
      int lines = 1,
      required BuildContext context,
      required TextEditingController controller}) {
    return Flexible(
      child: TextField(
        controller: controller,
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
          memberScreenController.selectDate(context);
        },
      ),
    );
  }

  Flexible _buildTextFieldTransDate(
      {required String hint,
      int lines = 1,
      required BuildContext context,
      required TextEditingController controller}) {
    return Flexible(
      child: TextField(
        controller: controller,
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
          transactionScreenController.selectTransactionDate(context);
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

  _buildDetailDialog(
      BuildContext context, Size size, String packageName, String id) {
    memberScreenController.getPincode(memberScreenController.pincode.value);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Update',
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
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.grey, width: 0.3),
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
                      Obx(() => Visibility(
                            visible: memberScreenController.fieldError.value,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('**Please fill all the fields',
                                  style: TextStyle(
                                      color: AppColors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Obx(
                            () => _buildTextField(
                              controller: TextEditingController(
                                  text: memberScreenController.name.value),
                              hint: 'Name',
                              textInputType: TextInputType.text,
                              onChanged: (value) =>
                                  memberScreenController.getName(value),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => _buildTextField(
                              controller: TextEditingController(
                                  text: memberScreenController.mobile.value),
                              hint: 'Mobile number',
                              onChanged: (value) =>
                                  memberScreenController.getMobile(value),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(() => Visibility(
                            visible: memberScreenController.mobileError.value,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Mobile number Already Exist',
                                  style: TextStyle(
                                      color: AppColors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: DropdownButtonFormField2(
                              decoration: _dropDownDecocration(),
                              isExpanded: true,
                              hint: Text(
                                memberScreenController.gender.value,
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
                                  EdgeInsets.symmetric(horizontal: 5),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.grey, width: 0.3),
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
                                memberScreenController
                                    .setGender(value.toString());
                              },
                              onSaved: (value) {
                                selectedValue = value.toString();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => _buildTextField(
                              controller: TextEditingController(
                                  text: memberScreenController.job.value),
                              hint: 'Job',
                              textInputType: TextInputType.text,
                              onChanged: (value) =>
                                  memberScreenController.getJob(value),
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
                                  text: memberScreenController.pincode.value),
                              hint: 'Pincode',
                              onChanged: (value) =>
                                  memberScreenController.getPincode(value),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => _buildTextField(
                              controller: TextEditingController(
                                  text: memberScreenController.state.value),
                              hint: 'State',
                              isReadOnly: true,
                              onChanged: (value) => print(value),
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
                                  text: memberScreenController.district.value),
                              hint: 'District',
                              isReadOnly: true,
                              onChanged: (value) => print(value),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Obx(() => DropdownButtonFormField2(
                                  decoration: _dropDownDecocration(),
                                  isExpanded: true,
                                  hint: Text(
                                    memberScreenController.area.value,
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
                                      EdgeInsets.symmetric(horizontal: 5),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.grey, width: 0.3),
                                  ),
                                  items: memberScreenController.areas.value
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
                                    memberScreenController
                                        .setArea(value.toString());
                                  },
                                  onSaved: (value) {
                                    selectedValue = value.toString();
                                  },
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => _buildTextField(
                              controller: TextEditingController(
                                  text: memberScreenController.address.value),
                              hint: 'Address',
                              textInputType: TextInputType.text,
                              onChanged: (value) =>
                                  memberScreenController.getAddress(value),
                              lines: 4,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Obx(
                                      () => _buildTextField(
                                        controller: TextEditingController(
                                            text: memberScreenController
                                                .weight.value),
                                        hint: 'Weight',
                                        onChanged: (value) =>
                                            memberScreenController
                                                .getWeight(value),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Obx(
                                      () => _buildTextField(
                                        controller: TextEditingController(
                                            text: memberScreenController
                                                .height.value),
                                        hint: 'Height',
                                        onChanged: (value) =>
                                            memberScreenController
                                                .getHeight(value),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Obx(
                                      () => _buildTextField(
                                        controller: TextEditingController(
                                            text: memberScreenController
                                                .age.value),
                                        hint: 'Age',
                                        onChanged: (value) =>
                                            memberScreenController
                                                .getAge(value),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Obx(
                                      () => _buildTextField(
                                        controller: TextEditingController(
                                            text:
                                                'BMI : ${memberScreenController.score.value}'),
                                        hint: 'Scroe',
                                        isReadOnly: true,
                                        onChanged: (value) => print(value),
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
                          Obx(
                            () => _buildTextFieldDate(
                                controller: TextEditingController(
                                    text: memberScreenController
                                        .joiningDate.value
                                        .toString()
                                    // dateFormat
                                    //     .format(DateTime.parse(
                                    //         memberScreenController
                                    //             .joiningDate.value))
                                    //     .toString()
                                    ),
                                hint: 'Joining Date',
                                context: context),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => _buildTextField(
                              controller: TextEditingController(
                                  text: memberScreenController.adhaar.value),
                              hint: 'Aadhaar number',
                              onChanged: (value) =>
                                  memberScreenController.getAdhaar(value),
                            ),
                          )
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
                                  text: memberScreenController
                                      .registrationFee.value),
                              hint: 'Registration Fee',
                              onChanged: (value) => memberScreenController
                                  .getRegistrationFee(value),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Obx(() => DropdownButtonFormField2(
                                  decoration: _dropDownDecocration(),
                                  isExpanded: true,
                                  hint: Text(
                                    packageName,
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
                                  buttonPadding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.grey, width: 0.3),
                                  ),
                                  items: memberScreenController.packages
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item.name,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.grey,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    selectedValue = value;
                                    memberScreenController.setPackage(
                                        selectedValue.id.toString());
                                  },
                                  onSaved: (value) {
                                    selectedValue = value.toString();
                                  },
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                              child: InkWell(
                            onTap: () {
                              memberScreenController.updateMember(
                                  context, id, true);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 0.3),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 12,
                                    ),
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
  }

  Column _buildTransDetailText({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: AppColors.white, fontSize: 8, fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Column _buildTransDetailTextRight(
      {required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: AppColors.white, fontSize: 8, fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
