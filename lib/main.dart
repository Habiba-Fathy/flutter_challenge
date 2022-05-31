import 'package:flutter/material.dart';
import 'package:flutter_challenge/providers/app_provider.dart';
import 'package:flutter_challenge/screens/home_screen.dart';
import 'package:flutter_challenge/utils/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
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
            MaterialApp(
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
        ),
      ),
    );
  }
}
