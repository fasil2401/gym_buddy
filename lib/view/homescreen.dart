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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: '',
        icon: Icons.person,
        onPressed: () => setState(() => _headline = 'member'),
        isSelected: true,
      ),

      CollapsibleItem(
        text: '',
        icon: Icons.payment_rounded,
        onPressed: () => setState(() => _headline = 'transaction'),
      ),
      CollapsibleItem(
        text: '',
        icon: Icons.settings_rounded,
        onPressed: () => setState(() => _headline = 'settings'),
      ),
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
