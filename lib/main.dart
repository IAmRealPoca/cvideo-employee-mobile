/*
 * File: main.dart
 * Project: CVideo
 * File Created: Thursday, 4th June 2020 10:38 am
 * Author: luonglvse130702 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Thursday, 4th June 2020 2:56 pm
 * Modified By: luonglvse130702 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:cvideo_mobile/src/blocs/blocs.dart';
import 'package:cvideo_mobile/src/blocs/simple_bloc_delegate.dart';
import 'package:cvideo_mobile/src/screens/scr006/screen006.dart';
import 'package:cvideo_mobile/src/screens/scr008/scr008.dart';
import 'package:cvideo_mobile/src/screens/scr005/profile_update.dart';
import 'package:cvideo_mobile/src/screens/scr005/scr005.dart';
import 'package:cvideo_mobile/src/screens/scr001/scr001.dart';
import 'package:cvideo_mobile/src/screens/scr003/screen003.dart';
import 'package:cvideo_mobile/src/app_components/app_components.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:cvideo_mobile/src/screens/scr002/scr002.dart';
import 'package:cvideo_mobile/src/screens/scr009/scr009.dart';
import 'package:cvideo_mobile/src/screens/scr010/scr010.dart';
import 'package:cvideo_mobile/src/screens/scr011/scr011.dart';
import 'package:cvideo_mobile/src/screens/scr012/scr012_main.dart';
import 'package:cvideo_mobile/src/screens/scr014/scr014.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/blocs/scr001/authentication/scr001_authentication_barrel.dart';

void main() async {
  /// This is used when using any plugins if the code is executed before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  /// Initial [AppLanguage]
  AppLanguage appLanguage = AppLanguage();

  /// Fetch language user's settings
  await appLanguage.fetchLocale();

  /// [SimpleBlocDelegate] helps all bloc state changes (transitions) and errors in one place.
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  MyApp({
    Key key,
    @required AppLanguage appLanguage,
  })  : this._appLanguage = appLanguage,
        super(key: key);

  final AppLanguage _appLanguage;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const NOTIFICATION_ID = 0;

  /// Initalize [FirebaseMessaging]
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  /// Initialize [FlutterLocalNotificationsPlugin]
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    /// Configure fcm
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage called: $message');
        print("title: ${message['notification']['title']}");
        _showNotification(
            title: message['notification']['title'],
            body: message['notification']['body']);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume called: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch called: $message');
      },
    );

    firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });

    /// Set [ic_launcher] for local notification
    var initializationSettingdAndroid =
        AndroidInitializationSettings('notification');
    var initializationSettingdIOS = IOSInitializationSettings();

    /// Initialize [InitializationSettings]
    var initializationSettings = InitializationSettings(
      initializationSettingdAndroid,
      initializationSettingdIOS,
    );

    /// Initialize [FlutterLocalNotificationsPlugin]
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  /// Handle when user click to local notification
  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    /// We can push to another screen here
  }

  /// Show local notification
  Future<void> _showNotification({
    @required String title,
    @required String body,
  }) async {
    /// Configure [AndroidNotificationDetails]
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Default Channel Id',
      'Defaulu Channel',
      'CVideo notification',
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      importance: Importance.Max,
      priority: Priority.High,
      enableVibration: true,
    );

    /// Configure [IOSNotificationDetails]
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    /// Configure [NotificationDetails]
    var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

    /// Show local notification
    await flutterLocalNotificationsPlugin.show(
      NOTIFICATION_ID,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Set color [AppColors.primaryDarkColor] for status bar.
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryDarkColor,
      ),
    );

    /// Initialize [LoginRepository] by injecting [FirebaseLoginRepository]
    final LoginRepository loginRepository = FirebaseLoginRepository();

    return ChangeNotifierProvider<AppLanguage>(
      create: (context) => widget._appLanguage,
      child: MultiProvider(
        providers: [
          /// BlocProvider for [AuthenticationBloc]
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              loginRepository: loginRepository,
              firebaseMessaging: firebaseMessaging,
            )..add(AuthenticationStarted()),
          ),

          /// Bloc provider for video recording and uploading
          BlocProvider<VideoBloc>(
            create: (context) => VideoBloc(
              scr008repository: SCR008Repository(
                scr008provider: SCR008Provider(),
              ),
            ),
          ),
        ],
        child: Consumer<AppLanguage>(
          builder: (context, value, child) =>
              BlocListener<VideoBloc, VideoState>(
            listener: (videoBlocStateContext, videoBlocState) async {
              var appLocalizations = AppLocalizations(value.appLocale);
              await appLocalizations.load();
              // Show nofications when record video
              if (videoBlocState is VideoStateSuccess) {
                _showNotification(
                  title: "Video Upload",
                  body:
                      appLocalizations.translate("scr008.infoMsgUploadSuccess"),
                );
              }
              if (videoBlocState is VideoStateUploading) {
                _showNotification(
                  title: "Video Upload",
                  body: appLocalizations.translate("scr008.infoMsgUploading"),
                );
              }
              if (videoBlocState is VideoStateFailure) {
                _showNotification(
                  title: "Video Upload",
                  body: appLocalizations.translate(videoBlocState.errorMsg),
                );
              }
            },
            child: MaterialApp(
              /// Hide the DEBUG banner on mobile screens.
              debugShowCheckedModeBanner: false,
              title: 'CVideo',
              theme: ThemeData(
                primaryColor: AppColors.primaryColor,
                fontFamily: Font_Family_Default,
              ),

              /// Define which languages to support
              supportedLocales: [
                Locale('vi', ''),
                Locale('en', ''),
              ],

              /// [localizationsDelegates]
              localizationsDelegates: [
                AppLocalizations.localizationsDelegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],

              /// Define locale use for the app
              locale: value.appLocale,

              /// Define routes for the app
              routes: <String, WidgetBuilder>{
                AppRoutes.SCR001_SCREEN: (BuildContext context) => SCR001(),
                AppRoutes.SCR008_SCREEN: (BuildContext context) => SCR008(),
                AppRoutes.SCR003_SCREEN: (BuildContext context) => SCR003(),
                AppRoutes.SCR006_SCREEN: (BuildContext context) => SCR006(),
                AppRoutes.SCR010_SCREEN: (BuildContext context) => SCR010(),
                AppRoutes.SCR011_SCREEN: (BuildContext context) => SCR011(),
                AppRoutes.SCR002_SCREEN: (BuildContext context) => SCR002(),
                AppRoutes.SCR005_SCREEN: (BuildContext context) => SCR005(),
                AppRoutes.UPDATE_EMPLOYEE_SCREEN: (BuildContext context) =>
                    ProfileUpdate(),
                AppRoutes.SCR014_SCREEN: (BuildContext context) => SCR014(),
                AppRoutes.SCR009_SCREEN: (BuildContext context) => SCR009(),
                AppRoutes.SCR012_MAIN_SCREEN: (BuildContext context) =>
                    SCR012Main(),
              },

              /// The initial route when the app start
              initialRoute: AppRoutes.SCR002_SCREEN,
            ),
          ),
        ),
      ),
    );
  }
}
