import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/dio_provider.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/features/acc&cards/data/models/response/get_cards_response/datum.dart';
import 'package:ibank/features/auth/presentation/screens/welcome/welcome_screen.dart';
import 'package:ibank/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioProvider.init();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(DatumAdapter());
  await AppLocalStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'iBank',
        home: const WelcomeScreen(),
      ),
    );
  }
}
