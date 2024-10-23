import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/constants/const_strings.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/model_otp.dart';
import '../../domain/entities/model_reset_password.dart';
import 'database_main.dart';

class DatabaseImpl implements MainDatabase {

  Future<Dio> dioConsts(bool isAuth) async {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers['Content-Type'] = 'application/json';
    // isAuth
    if (isAuth) {
      String token = GetStorage().read('token') ?? "";
      if (token.isNotEmpty) {
        dio.options.headers["Authorization"] = "Bearer $token";
      }
    }

    dio.options.followRedirects = false;
    // dio.options.validateStatus;

    dio.options.validateStatus = (status) {
      return status! <= 500;
    };
    return dio;
  }

  // final _db = FirebaseFirestore.instance;
  // static final DatabaseImpl _singleton = DatabaseImpl._internal();
  //
  // factory DatabaseImpl() {
  //   return _singleton;
  // }
  //
  // DatabaseImpl._internal();

  // Future<void> registerUser(AppUser user) async {
  //   print("${user.uid}  ID is-------");
  //   // print("${user.uid}  ID is-------");
  //   try {
  //     await _db.collection('users').doc(user.uid).set(user.toJson());
  //   } catch (e, s) {
  //     print('Exception @DatabaseService/registerPatient $e');
  //    print(s);
  //   }
  // }

  @override
  Future<Response> loginWithEmailPassword(AppUser user) async {
    String success = 'error';

    Dio dio = await dioConsts(false);
    try {
      print(user.toJson());
      var response = await dio.post('${ConstString.baseUrl}user/login',
          data: jsonEncode(user.toJson()));
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");

      return response;
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
    throw UnimplementedError();
  }


  @override
  Future<Response> registerUser(AppUser user) async {
    String success = 'error';

    Dio dio = await dioConsts(false);
    try {
      FormData formData = await user.formData();
      var response =
          await dio.post('${ConstString.baseUrl}user/register', data: formData);
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      return response;
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }

  @override
  Future<Response> forgetPass(AppUser user) async {
    String success = 'error';

    Dio dio = await dioConsts(false);
    try {
      print(user.toJson());
      var response = await dio.put(
          '${ConstString.baseUrl}user/forgot/${user.email}',
          data: jsonEncode(user.toJson()));

      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      return response;
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }



  @override
  Future<List<AppUser>> getAllUser() async {
    List<AppUser> lst = [];

    // try {
    //   final snapshot = await _db.collection('users').get();
    //
    //   List<DocumentSnapshot> docs = snapshot.docs;
    //   if (docs.isNotEmpty && docs.isNotEmpty) {
    //     print('docs : ${docs.length}');
    //     final dataTest = docs.map((e) => jsonEncode(e.data())).toList();
    //     lst = List<AppUser>.from(json.decode(dataTest.toString()).map((x) => AppUser.fromJson));
    //         // .map((x) => AppUser.fromMap(x)));
    //   }
    // } catch (e, s) {
    //   print('Exception @DatabaseService/getUserTests $e');
    // }
    return lst;
  }

  @override
  Future<AppUser?> getUser(String uid) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Response> resendOtp(ModelOTP mdl) async {
    String success = 'error';

    Dio dio = await dioConsts(false);
    try {
      print(mdl.toJson());
      var response = await dio.post('${ConstString.baseUrl}user/resend',
          data: jsonEncode(mdl.toJson()));
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      return response;
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }

  @override
  Future<Response> changePassword(ModelChangePassword mdl) async {
    Dio dio = await dioConsts(false);
    try {
      print(mdl.toJson());
      var response = await dio.post(
          '${ConstString.baseUrl}user/change-password',
          data: jsonEncode(mdl.toJson()));
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      return response;
    } catch (e) {
      print('the exception in change password is  $e');
    }
    throw UnimplementedError();
  }

  @override
  Future<Response> updateUser(AppUser user) async {
    String success = 'error';

    Dio dio = await dioConsts(true);
    try {
      FormData formData = FormData.fromMap({
        'profilePic': await MultipartFile.fromFile(user.file!.path,
            filename: DateTime.now().millisecondsSinceEpoch.toString()),
      });
      var response = await dio
          .put('${ConstString.baseUrl}user/update/${user.uid}', data: formData);
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      return response;
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }

  @override
  Future<Response> verifyOtp(ModelOTP mdl) async {
    String success = 'error';

    Dio dio = await dioConsts(false);
    try {
      print(mdl.toJson());
      var response = await dio.post('${ConstString.baseUrl}user/verify',
          data: jsonEncode(mdl.toJson()));
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      return response;
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }  @override
  Future<Response> passOtp(ModelOTP mdl) async {
    String success = 'error';

    Dio dio = await dioConsts(false);
    try {
      print(mdl.toJson());
      var response = await dio.put('${ConstString.baseUrl}user/reset',
          data: jsonEncode(mdl.toJson()));
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      return response;
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }

// Future<bool> loginWithEmailPassword(AppUser user) async {
//   bool isRegistered=false;
//   Dio dio = await dioConsts(false);
//   try {
//     print(user.toJson());
//     var response =
//     await dio.post('${ConstString.baseUrl}user/login',data: jsonEncode(user.toJson()));
//     print("Status Code : ${response.statusCode}");
//     print("Status Code : ${response.data.toString()}");
//     if(response.statusCode == 200 ||response.statusCode == 201){
//       isRegistered=true;
//     }
//   } catch (e) {
//     print('the exception in insertions is  $e');
//   }
//
//   return isRegistered;
// }


}
