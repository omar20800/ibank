import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/features/home/presentation/screens/home_screen.dart';
import 'package:ibank/features/message/presentation/screens/message_screen.dart';
import 'package:ibank/features/search/presentation/screens/search_screen.dart';
import 'package:ibank/features/settings/presentation/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    MessageScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      snackBar: const SnackBar(
        content: Text('Tap again to exit'),
        duration: Duration(seconds: 1),
        backgroundColor: AppColours.semanticColor1,
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: AppColours.naturalColor6,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColours.naturalColor1,
          selectedItemColor: AppColours.primaryColor1,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        body: screens[currentIndex],
      ),
    );
  }
}
