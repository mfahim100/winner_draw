import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:sqflite/sqflite.dart';
import '../../firebase_options.dart';
import 'injections.dart' as di;


class MainMethod{
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    var databasePath = await getDatabasesPath();
    print("Database path: $databasePath");
    await GetStorage.init();
    await di.init();
  }
}