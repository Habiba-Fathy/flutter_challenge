import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challenge/providers/app_provider.dart';
import 'package:flutter_challenge/screens/home_screen.dart';
import 'package:flutter_challenge/utils/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(),
        ),
      ],
      child: Consumer(
        builder: (BuildContext context, AppProvider app, Widget? child) =>
            Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              title: 'Flutter Challenge',
              debugShowCheckedModeBanner: false,
              theme: AppTheme().lightTheme,
              home: const HomeScreen(),
              locale: const Locale('ar', 'EG'),
              supportedLocales: const [Locale('ar', 'EG')],
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!),
            );
          },
        ),
      ),
    );
  }
}
