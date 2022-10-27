import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym/controller/home_controller.dart';
import 'package:gym/controller/member_screen_controller.dart';
import 'package:gym/controller/transaction_screen_controller.dart';
import 'package:gym/utils/constants/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gym/utils/date_formatter.dart';

class TransactionScreen {
  final HomeController homeController = Get.put(HomeController());
  final transactionScreenController = Get.put(TransactionScreenController());
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
                    'Transactions of Jiss Anto',
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
                          transactionScreenController.selectDate(context);
                        }),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
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
                      transactionScreenController
                          .setFilterStatus(value.toString());
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() => transactionScreenController.transactions.isEmpty
                  ? Center(
                      child: transactionScreenController.isLoading.value
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
                      itemCount:
                          transactionScreenController.transactions.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var transaction =
                            transactionScreenController.transactions[index];
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
                                      fontWeight: FontWeight.w500),
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
                                      fontWeight: FontWeight.w400),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              _buildIconTile(
                                  icon: Icons.person,
                                  title: 'Details',
                                  onTap: () {
                                    transactionScreenController
                                        .getTransactionById(transaction.id);
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                      'Transactions Details',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color:
                                                                AppColors.grey,
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.3),
                                              content: Obx(
                                                () => Container(
                                                    width: 400,
                                                    height: size.height * 0.5,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: transactionScreenController
                                                              .isLoading.value
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                              color: AppColors
                                                                  .white,
                                                            ))
                                                          : Column(
                                                              children: [
                                                                Card(
                                                                  color:
                                                                      AppColors
                                                                          .glass,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            15),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        _buildTransDetailText(
                                                                            title:
                                                                                'Transaction ID',
                                                                            value:
                                                                                transactionScreenController.transaction.value.data!.trxId),
                                                                        _buildTransDetailTextRight(
                                                                            title:
                                                                                'Payment Mode',
                                                                            value:
                                                                                'Gpay/Cash'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Card(
                                                                  color:
                                                                      AppColors
                                                                          .glass,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            15),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        _buildTransDetailText(
                                                                            title:
                                                                                'Customer Name',
                                                                            value:
                                                                                transactionScreenController.transaction.value.data!.customer.name),
                                                                        Text(
                                                                          'GS654',
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: AppColors.white,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Card(
                                                                  color:
                                                                      AppColors
                                                                          .glass,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            15),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        _buildTransDetailText(
                                                                            title:
                                                                                'Package',
                                                                            value:
                                                                                transaction.package.name),
                                                                        Text(
                                                                          'Rs. ${transaction.package.price}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              color: AppColors.white,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Card(
                                                                  color:
                                                                      AppColors
                                                                          .glass,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            15),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        _buildTransDetailText(
                                                                            title:
                                                                                'Transaction Note',
                                                                            value:
                                                                                transactionScreenController.transaction.value.data!.notes),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Card(
                                                                        color: AppColors
                                                                            .glass,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 20,
                                                                              vertical: 15),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
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
                                                                      child:
                                                                          Card(
                                                                        color: AppColors
                                                                            .glass,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 20,
                                                                              vertical: 15),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
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
                        transactionScreenController.previousPage();
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  _buildIconTileRight(
                      icon: Icons.skip_next,
                      title: 'Next',
                      onTap: () {
                        transactionScreenController.nextPage();
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
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Add Transaction to Jiss Anto',
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
                                    height: size.height * 0.4,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              _buildTextField(
                                                hint: 'TXNGS-3429',
                                                onChanged: (value) =>
                                                    print(value),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              _buildTextField(
                                                hint: 'Transaction Date',
                                                onChanged: (value) =>
                                                    print(value),
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
                                                    'Payment Mode',
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
                                                    //Do something when changing the item if you want.
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
                                                hint: 'Transaction Fee',
                                                onChanged: (value) =>
                                                    print(value),
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
                                                hint: 'Transaction Note',
                                                onChanged: (value) =>
                                                    print(value),
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
                                                          child:
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
                                                            items: genderItems
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
                                                              //Do something when changing the item if you want.
                                                            },
                                                            onSaved: (value) {
                                                              selectedValue =
                                                                  value
                                                                      .toString();
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        _buildTextField(
                                                          hint:
                                                              'Package Amount',
                                                          onChanged: (value) =>
                                                              print(value),
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
                                              Container(
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 8),
                                                    child: Text(
                                                      'Add',
                                                      style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 12,
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
      int lines = 1}) {
    return Flexible(
      child: TextField(
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 12,
        ),
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
