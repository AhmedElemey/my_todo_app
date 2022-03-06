import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/views/done_screen.dart';
import 'package:my_todo_app/views/tasks_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const TasksScreen(),
      const DoneScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.task,
            color: Colors.white,
          ),
          inactiveIcon: Icon(
            Icons.task,
            color: CupertinoColors.white.withOpacity(0.6),
          ),
          iconSize: 24,
          title: ("Tasks"),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: CupertinoColors.white.withOpacity(.6)),
      PersistentBottomNavBarItem(
          iconSize: 24,
          icon: const Icon(
            Icons.done_all,
            color: Colors.white,

          ),
          inactiveIcon: Icon(Icons.done_all,
              color: CupertinoColors.white.withOpacity(.6)),
          title: ("Done"),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: CupertinoColors.white.withOpacity(.6)),
    ];
  }

  // bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      padding: const NavBarPadding.only(top: 22),
      // backgroundColor: Colors.white,
      backgroundColor: const Color(0xff00214E),
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.transparent,
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(180, 22),
        ),
      ),
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style8,
      // Choose the nav bar style with this property.
      navBarHeight: MediaQuery.of(context).size.height * 0.09,
    );
  }
}
