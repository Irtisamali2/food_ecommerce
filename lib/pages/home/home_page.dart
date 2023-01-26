import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ecommerce/pages/account/account_page.dart';
import 'package:food_ecommerce/pages/auth/sign_up_page.dart';
import 'package:food_ecommerce/pages/cart/cart_history.dart';
import 'package:food_ecommerce/pages/home/main_food_page.dart';
import 'package:food_ecommerce/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../auth/sign_in_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int _iselectedIndex=0;
late PersistentTabController _controller;
  // List page=[
  //       MainFoodPage(),
  //       Container(child: Center(child: Text("First Page")),),
  //       Container(child: Center(child: Text("Next Page")),),
  //       Container(child: Center(child: Text("Next Next Page")),),


  // ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }
  void onTapNav(int index){
    setState(() {
      _iselectedIndex=index;
    });
  }
  List<Widget> _buildScreens() {
        return const [
        MainFoodPage(),
        SignInPage(),
        CartHistory(),
        AccountPage()
        ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.archivebox_fill),
                title: ("Archive"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
             PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.cart_fill),
                title: ("Cart"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.person),
                title: ("Me"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
        ];
    }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: page[_iselectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       selectedItemColor: AppColors.mainColor,
  //       unselectedItemColor: Colors.amberAccent,
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       currentIndex: _iselectedIndex,
  //       onTap: onTapNav,
  //       items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
  //       label: "home" ),
  //       BottomNavigationBarItem(icon: Icon(Icons.archive),
  //       label: "history" ),
  //       BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
  //       label: "cart" ),
  //       BottomNavigationBarItem(icon: Icon(Icons.person),
  //       label: "me" ),
  //     ]),
  //   );
  // }

@override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}