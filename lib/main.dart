import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'core/controllers/check_provider.dart';
import 'core/routes/app_pages.dart';
import 'core/utils/injections.dart' as di;
import 'core/controllers/theme_controller.dart';
import 'core/utils/main_method.dart';

Future<void> main() async {
 await MainMethod.init();
 print("::::VVVV:::::");
 print(DateTime.now().toString());
 print(DateTime.now().timeZoneOffset);
 print(DateTime.now().subtract(DateTime.now().timeZoneOffset).toString());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    di.sl<ThemeController>().loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CheckProvider())
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return
            // Obx(
            // () =>
                GetMaterialApp(
              debugShowCheckedModeBanner: false,
              smartManagement: SmartManagement.full,
              title: 'Winner Draw',
              theme: ThemeData.light(),
              // theme: ThemeStyles.themeData(
              //     di.sl<ThemeController>().darkTheme.value, context),
              initialRoute: Routes.SPLASH,
              getPages: AppPages.pages,
              //     home: ClientRequestForDeleteAccount(),
              builder: EasyLoading.init(),
            // ),
          );
        },
      ),
    );
  }
}
