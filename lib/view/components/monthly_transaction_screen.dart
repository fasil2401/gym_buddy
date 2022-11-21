import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:gym/controller/home_controller.dart';
import 'package:gym/controller/monthly_transaction_controller.dart';
import 'package:gym/utils/constants/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:gym/utils/date_formatter.dart';

class MonthlyTransactionScreen {
  final transactionController = Get.put(MonthlyTransactionController());

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
                    'Monthly Transaction',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _buildIconTile(
                    icon: Icons.calendar_month_rounded,
                    title: 'Date',
                    onTap: () {
                      transactionController.selectDate(context);
                    }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(
                () => transactionController.transactions.isEmpty
                    ? Center(
                        child: transactionController.isLoading.value
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
                        itemCount: transactionController.transactions.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var transaction =
                              transactionController.transactions[index];
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
                                      head: transaction.name.toString(),
                                      body: ''),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    transaction.mobile.toString(),
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
                                    '',
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
                                    '₹ ${transaction.paid.toString()}',
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
                                                        color: AppColors.white,
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
                                                          BorderRadius.circular(
                                                              5),
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.3),
                                            content: Obx(
                                              () => Container(
                                                width: 400,
                                                height: size.height * 0.5,
                                                child: SingleChildScrollView(
                                                  child: transactionController
                                                          .isLoading.value
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                          color:
                                                              AppColors.white,
                                                        ))
                                                      : Column(
                                                          children: [
                                                            ListView.builder(
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                var detail =
                                                                    transaction
                                                                            .transactions[
                                                                        index];
                                                                return ListTile(
                                                                  title: Text(detail
                                                                      .trxId
                                                                      .toString()),
                                                                  subtitle: Text(dateFormat
                                                                      .format(detail
                                                                          .date)
                                                                      .toString()),
                                                                  trailing: Text(
                                                                      '₹ ${detail.amount.toString()}'),
                                                                );
                                                              },
                                                              itemCount: transaction
                                                                          .transactions ==
                                                                      null
                                                                  ? 0
                                                                  : transaction
                                                                      .transactions
                                                                      .length,
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                            ),
                                                          ],
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
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
                        transactionController.previousPage();
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Obx(() => Text(
                        '${transactionController.pageNumber.value}',
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
                        transactionController.nextPage();
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
