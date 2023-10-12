import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/Authorize/controllers/auth/user_controller.dart';
// import 'package:todo/features/onboard/login_page.dart';
import 'package:todo/features/onboard/onboard_screen.dart';
// import 'package:todo/features/onboard/welcome_page.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/utilties/user_model.dart';
import 'package:todo/features/onboard/dashboard_home.dart';
import 'Authorize/controllers/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp(
      const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.cyan);

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark, primarySwatch: Colors.cyan);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users=ref.watch(userProvider);
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 875),
        minTextAdapt: true,
        builder: (context, materialApp) {
          return DynamicColorBuilder(builder: (lightScheme, darkScheme) {
            return MaterialApp(
              title: 'Todo App',
              theme: ThemeData(
                scaffoldBackgroundColor: Constants.kBlueDark.withOpacity(.2),
                useMaterial3: true
              ),
              darkTheme: ThemeData(
                colorScheme: darkScheme??defaultDarkColorScheme,
                scaffoldBackgroundColor: Constants.kBlueDark.withOpacity(.2),
                useMaterial3: true
              ),
              home: users.isEmpty? const OnBoard():const HomeScreen(),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: Routes.onGenerated,
            );
          });
        });
  }
}
