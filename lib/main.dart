import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'constants/AppColors.dart';
import 'firebase_options.dart';
import 'package:pd_project/services/authentication/Login_Screen.dart';
import 'package:pd_project/services/firebse_Controllers/auth_Controller.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp()); // Wrap your app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Login_Controller(),
        ),
      ],
      child: GetMaterialApp(
          title: "PD App",
          color: AppColors.blue,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: Login_Screen()),
    );
  }
}
