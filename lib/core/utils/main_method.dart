import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../firebase_options.dart';
import '../constants/const_strings.dart';
import 'injections.dart' as di;


class MainMethod{
  static Future<void> init() async {
    // Dart client
    // IO.Socket socket = IO.io(ConstString.mainUrl,IO.OptionBuilder().setTransports(['websocket']).build());
    // socket.onConnect((_) {
    //   print('sockettttt connect');
    //   socket.emit('drawOpened', 'test');
    // });
    // socket.on('drawOpened', (data) {
    //   print("sockettttt");
    //   print(data);
    // });
    // socket.on('event', (data) => print(data));
    // socket.onDisconnect((_) => print('sockettttt disconnect'));
    // socket.on('fromServer', (_) => print(_));
    // socket.onConnectError((data)=>print('sockettttt connection error'));
    //


    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await GetStorage.init();
    await di.init();
  }
}