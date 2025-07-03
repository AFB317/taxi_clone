import 'package:duma_taxi/screens/pages/main/home/search.dart';
import 'package:duma_taxi/screens/pages/main/main.dart';
import 'package:duma_taxi/screens/pages/sign_in.dart';
import 'package:duma_taxi/screens/pages/sign_up.dart';
import 'package:duma_taxi/screens/pages/splash.dart';
import 'package:duma_taxi/screens/pages/welcome.dart';
import 'package:duma_taxi/utils/check_connection.dart';
import 'package:duma_taxi/utils/constants.dart';
import 'package:duma_taxi/utils/data_manager.dart';
import 'package:duma_taxi/utils/enumerations.dart';
import 'package:duma_taxi/utils/firebase_options.dart';
import 'package:duma_taxi/utils/languages/constants.dart';
import 'package:duma_taxi/utils/languages/settings.dart';
import 'package:duma_taxi/utils/preferences.dart';
import 'package:duma_taxi/utils/providers/connected.dart';
import 'package:duma_taxi/utils/providers/initial.dart';
import 'package:duma_taxi/utils/providers/text.dart';
import 'package:duma_taxi/utils/theme/manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => InitialProvider()),
        ChangeNotifierProvider(create: (_) => ConnectedProvider()),
        ChangeNotifierProvider(create: (_) => TextProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
    DataManager().language = locale.languageCode;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then(
      (locale) => {
        setState(() {
          _locale = locale;
        }),
      },
    );
    super.didChangeDependencies();
  }

  @override
  void initState() {
    PreferenceUtils.getPreferences();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<InitialProvider>(context, listen: false).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        if (_locale == null) {
          return const SizedBox();
        }
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: appName,
          debugShowMaterialGrid: false,
          localizationsDelegates: const [
            LanguageSettings.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          supportedLocales: const [
            Locale('fr', 'FR'),
            Locale('es', 'ES'),
            Locale('en', 'UK'),
            Locale('sw', 'SW'),
            Locale('am', 'AM'),
            Locale('hr', 'HR'),
            Locale('ro', 'RO'),
          ],
          theme: _themeData(themeManager.theme),
          darkTheme: _themeData(themeManager.theme),
          key: themeManager.key,
          routerConfig: _router,
        );
      },
    );
  }

  final GoRouter _router = GoRouter(
    navigatorKey: MyApp.navigatorKey,
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SplashPage(),
        routes: [
          GoRoute(
            path: "${RouterPath.check}",
            builder: (context, state) => CheckConnection(),
          ),
          GoRoute(
            path: "${RouterPath.welcome}",
            builder: (context, state) => WelcomePage(),
            routes: [
              GoRoute(
                path: "${RouterPath.signUp}",
                builder: (context, state) => const SignUpPage(),
              ),
              GoRoute(
                path: "${RouterPath.signIn}",
                builder: (context, state) => const SignInPage(),
              ),
            ],
          ),
          GoRoute(
            path: "${RouterPath.main}",
            builder: (context, state) => MainPage(),
            routes: [
              GoRoute(
                path: "${RouterPath.search}",
                builder: (context, state) => const SearchPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ThemeData _themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.ralewayTextTheme(theme.textTheme),
    );
  }
}
