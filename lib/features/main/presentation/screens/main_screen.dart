import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/features/home/presentation/screens/home_screen.dart';
import 'package:ibank/features/message/presentation/screens/message_screen.dart';
import 'package:ibank/features/search/presentation/screens/search_screen.dart';
import 'package:ibank/features/settings/presentation/screens/settings_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return PersistentTabView(
      context,
      navBarStyle: NavBarStyle.style7,
      decoration: NavBarDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: AppColours.naturalColor4,
            spreadRadius: 0.5,
          ),
        ],
      ),
      controller: PersistentTabController(initialIndex: currentIndex),
      screens: [
        HomeScreen(),
        SearchScreen(),
        MessageScreen(),
        SettingsScreen(maincontext: context),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset('assets/icons/Home2.svg'),
          title: "Home",
          activeColorPrimary: AppColours.primaryColor1,
          activeColorSecondary: AppColours.naturalColor6,
          inactiveColorPrimary: AppColours.naturalColor4,
          inactiveIcon: SvgPicture.asset('assets/icons/Home1.svg'),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset('assets/icons/Search2.svg'),
          title: "Search",
          activeColorPrimary: AppColours.primaryColor1,
          activeColorSecondary: AppColours.naturalColor6,
          inactiveColorPrimary: AppColours.naturalColor4,
          inactiveIcon: SvgPicture.asset('assets/icons/Search1.svg'),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset('assets/icons/Message2.svg'),
          title: "Messages",
          activeColorPrimary: AppColours.primaryColor1,
          activeColorSecondary: AppColours.naturalColor6,
          inactiveColorPrimary: AppColours.naturalColor4,
          inactiveIcon: SvgPicture.asset('assets/icons/Message1.svg'),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset('assets/icons/Settings2.svg'),
          title: "Settings",
          activeColorPrimary: AppColours.primaryColor1,
          activeColorSecondary: AppColours.naturalColor6,
          inactiveColorPrimary: AppColours.naturalColor4,
          inactiveIcon: SvgPicture.asset('assets/icons/Settings1.svg'),
        ),
      ],
    );
  }
}
