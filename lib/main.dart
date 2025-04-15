import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_management/screens/root/root.dart';
import 'package:gym_management/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
ValueNotifier<bool> isThemeDark = ValueNotifier(false);

const String userBoxName = 'userBox';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  isThemeDark.value = sharedPreferences.getBool('isDark') ?? false;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('fa'), Locale('en')],
      path: 'assets/translations',
      startLocale: const Locale('fa'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isThemeDark,
      builder: (context, value, child) {
        return MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child as Widget,
            );
          },

          debugShowCheckedModeBanner: false,
          theme: lightTheme(
            context.locale == const Locale('en') ? 'Gilroy' : 'YekanBakh',
          ),
          darkTheme: darkTheme(
            context.locale == const Locale('en') ? 'Gilroy' : 'YekanBakh',
          ),
          themeMode: isThemeDark.value ? ThemeMode.dark : ThemeMode.light,
          home: const RootScreen(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
