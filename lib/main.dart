import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pro/providers.dart';
import 'package:test_pro/providers/app_provider.dart';
import 'package:test_pro/providers/local_storage_provider.dart';
import 'package:test_pro/routes.dart';

import 'app_wrapper.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      FlutterError.onError = (FlutterErrorDetails? details) {
        Zone.current.handleUncaughtError(details!.exception, details.stack!);
      };
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await LocalStorage().isReady();
      AppProvider appProvider = AppProvider();
      await appProvider.bootActions();
      runApp(MyApp(
        appProvider: appProvider,
      ));
    },
    (error, st) => print(error),
  );
}

class MyApp extends StatefulWidget {
  final AppProvider appProvider;

  const MyApp({Key? key, required this.appProvider}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: widget.appProvider,
        ),
        ...providers,
      ],
      child: Consumer<AppProvider>(
        builder: (c, app, _) => MaterialApp(
          navigatorKey: app.navKey,
          debugShowCheckedModeBanner: false,
          title: 'Test Pro',
          home: AppWrapper(),
          routes: routes,
        ),
      ),
    );
  }
}
