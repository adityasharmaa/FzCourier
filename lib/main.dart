import 'package:fz_courier/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Locale/locales.dart';
import 'Theme/style.dart';
import 'package:fz_courier/Routes/routes.dart';
import 'package:fz_courier/Authentication/signin_navigator.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: kTransparentColor,
      statusBarIconBrightness: Brightness.dark));
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
        const Locale('pt'),
        const Locale('fr'),
        const Locale('id'),
        const Locale('es'),
      ],
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: SignInNavigator(),
      routes: PageRoutes().routes(),
    );
  }
}
