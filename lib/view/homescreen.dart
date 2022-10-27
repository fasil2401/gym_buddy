import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:gym/controller/home_controller.dart';
import 'package:gym/utils/constants/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:gym/view/components/member_screen.dart';
import 'package:gym/view/components/setting_screen.dart';
import 'package:gym/view/components/transaction_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (isDeviceConnected && isAlertSet == false) {
        showNetWorkDialog();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  final HomeController homeController = Get.put(HomeController());

  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  final List<String> statusItems = [
    'Active',
    'Inactive',
  ];

  String? selectedValue;
  late List<CollapsibleItem> _items;
  String? _headline;
  AssetImage _avatarImg = AssetImage('assets/images/applogo.png');

  @override
  void initState() {
    getConnectivity();
    super.initState();
    _items = _generateItems;
    _headline = 'member';
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  showNetWorkDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                width: 400,
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/network_fail.png'),
                                fit: BoxFit.cover,
                              ),
                              color: AppColors.white,
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              setState(() {
                                isAlertSet = false;
                              });
                              isDeviceConnected =
                                  await InternetConnectionChecker()
                                      .hasConnection;
                              if (isDeviceConnected) {
                                showNetWorkDialog();
                                setState(() {
                                  isAlertSet = true;
                                });
                              }
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  child: Text(
                                    'Refresh',
                                    style: TextStyle(
                                      color: AppColors.white,
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
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: '',
        icon: Icons.person,
        onPressed: () {
          setState(() => _headline = 'member');
          // homeController.switchTransaction(false);
        },
        isSelected: true,
      ),

      CollapsibleItem(
        text: '',
        icon: Icons.payment_rounded,
        onPressed: () {
          setState(() => _headline = 'transaction');
        },
      ),
      // CollapsibleItem(
      //   text: '',
      //   icon: Icons.settings_rounded,
      //   onPressed: () => setState(() => _headline = 'settings'),
      // ),
      // CollapsibleItem(
      //   text: '',
      //   icon: Icons.fitness_center_rounded,
      //   onPressed: () => setState(() => _headline = 'Notifications'),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.black,
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  AppColors.black.withOpacity(0.9), BlendMode.overlay),
            ),
          ),
          child: CollapsibleSidebar(
            isCollapsed: MediaQuery.of(context).size.width <= size.width,
            items: _items,
            avatarImg: _avatarImg,
            title: '',
            screenPadding: 20,
            body: _headline == 'member'
                ? MemberScreen().body(size, context)
                : _headline == 'transaction'
                    ? TransactionScreen().body(size, context)
                    : SettingsScreen().body(size, context),
            showToggleButton: false,
            backgroundColor: Colors.grey.withOpacity(0.2),
            selectedIconColor: AppColors.white,
            unselectedIconColor: AppColors.grey,
            textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            titleStyle: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
            toggleTitleStyle:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            sidebarBoxShadow: [
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 1,
                spreadRadius: 0.00,
                // offset: Offset(3, 3),
              ),
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 1,
                spreadRadius: 0.00,
                // offset: Offset(3, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
