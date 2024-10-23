import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/constants/const_strings.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../auth/domain/entities/app_user.dart';
import '../../../../auth/domain/entities/model_bank.dart';
import '../../../../client/main_client/presentation/manager/main_nav_client_controller.dart';
import '../../domain/entities/model_participants.dart';
import '../../domain/entities/model_photos.dart';
import '../../domain/entities/model_photos_comment.dart';
import '../../domain/entities/model_prize.dart';
import '../../domain/entities/model_results.dart';
import '../../domain/entities/model_slider.dart';
import '../../domain/entities/request_model.dart';
import 'admin_database_main.dart';

class AdminDatabaseImpl implements AdminMainDatabase {


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
    dio.options.validateStatus = (status) {
      return status! < 500;
    };
    return dio;
  }

  @override
  Future<bool> addCurrentLucyDraw(ModelPrize prize) async {
    bool isAdded = false;
    Dio dio = await dioConsts(true);

    try {
      print(prize.toJson());
      // FormData formData = FormData.fromMap({
      //
      //   'id' : prize.id,
      //   'drawNumber' :
      //   prize.no == 1?"First":
      //   prize.no == 2?"Second":"Third"
      //   ,
      //
      //   'uid' : prize.uid,
      //   'imgUrl' : await  MultipartFile.fromFile(prize.file!.path, filename: DateTime.now().millisecondsSinceEpoch.toString()),
      //   'title' : prize.title,
      //   'price' : prize.price,
      //   'openAt' : DateTime.fromMillisecondsSinceEpoch(prize.timer!).toString(),
      //   'status' : "active",
      //   'description' : prize.description,
      //
      //   'createdAt' : prize.createdAt,
      //   'updatedAt' : prize.updatedAt,
      // });
      FormData formData = await prize.formData();

      var response =
          await dio.post('${ConstString.baseUrl}draw', data: formData);

      print("Status Code : ${response.statusCode}");
      print("Status Code : ${response.data.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        isAdded = true;
      }
    } catch (e) {
      print('the exception in insertions is  $e');
    }

    return isAdded;
  }

  @override
  Future<bool> updateCurrentLucyDraw(ModelPrize prize) async {
    bool isAdded = false;
    Dio dio = await dioConsts(true);

    try {
      print(prize.toJson());

      FormData formData = await prize.formData();

      var response = await dio
          .put('${ConstString.baseUrl}draw/edit/${prize.id}', data: formData);

      print("Status Code : ${response.statusCode}");
      print("Status Code : ${response.data.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        isAdded = true;
      }
    } catch (e) {
      print('the exception in insertions is  $e');
    }

    return isAdded;
  }

  @override
  Future<List<ModelPrize>> getCurrentLuckyDraw() async {
    List<ModelPrize> modelPrize = [];

    Dio dio = await dioConsts(true);
    try {
      var response = await dio.get('${ConstString.baseUrl}draw');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
        } else {
          List<dynamic> jsonList = response.data["data"];
          for (var element in jsonList) {
            modelPrize.add(ModelPrize.fromJson(element));
          }
        }
      }
    } catch (e) {
      print('The exceptions in fetching all Lucky Draws is $e');
    }
    return modelPrize;
  }


  /// Participant Section )(*&^%$#@!@#$%^&*()(*&^%$#@!@#@#$%^%$#@!!@#$%^&*!@
  @override
  Future<List<ModelParticipants>> getParticipants() async {
    List<ModelParticipants> lst = [];

    try {
      Dio dio = await dioConsts(true);
      String drawId = GetStorage().read("drawId") ?? "";
      var response = await dio.get('${ConstString.baseUrl}participant/$drawId');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("ASDASDASDASDASD");
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
        } else {
          List<dynamic> jsonList = response.data["data"];
          for (var element in jsonList) {
            print("ASDASDASDASDASD");
            print(element.toString());
            lst.add(ModelParticipants.fromMap(element));
          }
        }
      }
    } catch (e, s) {
      print('Exception @DatabaseService/getParticipants $e');
    }
    return lst;
  }

  @override
  Future<bool> addParticipant(    String userId) async {
    String drawId1 = GetStorage().read("drawId1") ?? "";
    String drawId2 = GetStorage().read("drawId2") ?? "";
    String drawId3 = GetStorage().read("drawId3") ?? "";
    try {
      Dio dio = await dioConsts(true);

      var response = await dio.post('${ConstString.baseUrl}participant',
          data: jsonEncode({"participant": userId, "draw": drawId1}));
      var response2 = await dio.post('${ConstString.baseUrl}participant',
          data: jsonEncode({"participant": userId, "draw": drawId2}));
      var response3 = await dio.post('${ConstString.baseUrl}participant',
          data: jsonEncode({"participant": userId, "draw": drawId3}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
          return false;
        } else {
          if (response.data["success"] == "true") {
            return true;
          }
          return false;
        }
      }
    } catch (e, s) {
      print('Exception @DatabaseService/addParticipant $e');
    }
    return false;
  }

  @override
  Future<bool> deleteParticipant(String uid) async {
    // try {
    //   await _db.collection('participants').doc(uid).delete();
    //   return true;
    // } catch (e, s) {
    //   print('Exception @DatabaseService/registerPatient $e');
    // }
    return false;
  }

  /// Photo Section )(*&^%$#@!@#$%^&*()(*&^%$#@!@#@#$%^%$#@!!@#$%^&*!@
  @override
  Future<bool> addPhotos(ModelPhotos photos) async {
    Dio dio = await dioConsts(true);

    FormData formData = await photos.formData();
    try {
      var response =
          await dio.post('${ConstString.baseUrl}post', data: formData);
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
          return false;
        } else {
          if (response.data["success"] == "true") {
            return true;
          }
          return false;
        }
      }
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }

  @override
  Future<List<ModelPhotos>> getPhotos() async {
    List<ModelPhotos> lst = [];

    try {
      Dio dio = await dioConsts(true);
      var response = await dio.get('${ConstString.baseUrl}post');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
        } else {
          List<dynamic> jsonList = response.data["data"];
          for (var element in jsonList) {
            lst.add(ModelPhotos.fromMap(element));
          }
        }
      }
    } catch (e, s) {
      print('Exception @DatabaseService/getPhotos $e');
    }
    List<ModelPhotos> lstX = [];
    for (var element in lst) {
      ModelPhotos p = await getLikesComments(element);
      lstX.add(p);
    }
    ;
    return lstX;
  }

  @override
  Future<bool> likeDislike(ModelPhotos photos) async {
    Dio dio = await dioConsts(true);
    try {
      var response = await dio.post('${ConstString.baseUrl}like',
          data: jsonEncode(photos.toJsonApi()));
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
          return false;
        } else {
          if (response.data["success"] == "true") {
            return true;
          }
          return true;
        }
      }
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }

  @override
  Future<ModelPhotos> getLikesComments(ModelPhotos photos) async {
    List<dynamic> lstLikes = [];
    List<ModelPhotoComments> lstComments = await getPhotoComments(photos.id!);

    int status = 0;
    String userId = GetStorage().read("UserId") ?? "";

    ModelPhotos photo = photos;

    try {
      Dio dio = await dioConsts(true);
      var response = await dio.get('${ConstString.baseUrl}like/${photo.id}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
        } else {
          List<dynamic> jsonList = response.data["data"]["Likes"];
          for (var element in jsonList) {
            lstLikes.add(element);
            if (element["user"]["_id"] == userId) {
              status = 1;
            }
          }
        }
      }
    } catch (e, s) {
      print('Exception @DatabaseService/getLikesComments $e');
    }

    photo = photos.copyWith(
        like: lstLikes.length, comment: lstComments.length, status: status);

    return photo;
  }

  @override
  Future<bool> addPhotoComments(ModelPhotoComments comment) async {
    Dio dio = await dioConsts(true);
    try {
      var response = await dio.post('${ConstString.baseUrl}comment',
          data: jsonEncode(comment.toJsonApi()));
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
          return false;
        } else {
          if (response.data["success"] == "true") {
            return true;
          }
          return true;
        }
      }
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }

  @override
  Future<List<ModelPhotoComments>> getPhotoComments(String pid) async {
    List<ModelPhotoComments> lst = [];
    Dio dio = await dioConsts(true);
    try {
      var response = await dio.get('${ConstString.baseUrl}comment/$pid');
      print("Status Code : ${response.statusCode}");
      print(response.data["data"].toString());
      if (response.data["data"] == null) {
      } else {
        List<dynamic> jsonList = response.data["data"]["comments"];
        for (var element in jsonList) {
          lst.add(ModelPhotoComments.fromMap(element));
        }
      }
    } catch (e, s) {
      print('Exception @DatabaseService/getPhotoComments $e');
    }
    return lst;
  }

  @override
  Future<bool> deletePhoto(ModelPhotos photos) async {
    Dio dio = await dioConsts(true);
    print(photos.imgUrl);
    print(photos.imgUrl);
    try {
      var response =
          await dio.delete('${ConstString.baseUrl}post/delete/${photos.id}');
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }

  /// Results Section )(*&^%$#@!@#$%^&*()(*&^%$#@!@#@#$%^%$#@!!@#$%^&*!@
  @override
  Future<List<List<ModelResults>>> getResults() async {
    print("getResults");
    List<List<ModelResults>> lstX = [];

    Dio dio = await dioConsts(true);
    try {
      print("getResults in try");
      var response = await dio.get('${ConstString.baseUrl}result');
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      print(response.data["data"].toString());
      if (response.data["data"] == null) {
      } else {
        List<dynamic> jsonList = response.data["data"];
        for (var element in jsonList) {
          lstX.add([ModelResults.fromMap(element)]);
          print("getResults length ${lstX.length}");
        }
      }
    } catch (e, s) {
      print('Exception @DatabaseService/getResults $e');
    }
    return lstX;
  }

  @override
  Future<List<ModelResults>> getCurrentResults() async {
    List<ModelResults> lstX = [];
    Dio dio = await dioConsts(true);
    try {
      var response = await dio.get('${ConstString.baseUrl}result');
      print(" ::::::::::: Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      print(response.data["data"].toString());
      if (response.data["data"] == null) {
      } else {
        List<dynamic> jsonList = response.data["data"];
        List<ModelResults> lst = [];
        for (var element in jsonList) {
          lst.add(ModelResults.fromMap(element));
        }
        lstX = getUniqueLastDraw(lst);
      }
    } catch (e) {
      print('Exception @DatabaseService/getCurrentResults $e');
    }
    return lstX;
  }

  List<ModelResults> getUniqueLastDraw(List<ModelResults> lst) {
    List<ModelResults> lstX = [];
    ModelResults? first;
    ModelResults? second;
    ModelResults? third;

    for (var value in lst) {
      if (value.prizeNo == 1) {
        if (first == null) {
          first = value;
        } else {
          if (DateTime.fromMillisecondsSinceEpoch(first.timer!)
                  .millisecondsSinceEpoch <
              DateTime.fromMillisecondsSinceEpoch(value.timer!)
                  .millisecondsSinceEpoch) {
            first = value;
          }
        }
      } else if (value.prizeNo == 2) {
        if (second == null) {
          second = value;
        } else {
          if (DateTime.fromMillisecondsSinceEpoch(second.timer!)
                  .millisecondsSinceEpoch <
              DateTime.fromMillisecondsSinceEpoch(value.timer!)
                  .millisecondsSinceEpoch) {
            second = value;
          }
        }
      } else if (value.prizeNo == 3) {
        if (third == null) {
          third = value;
        } else {
          if (DateTime.fromMillisecondsSinceEpoch(third.timer!)
                  .millisecondsSinceEpoch <
              DateTime.fromMillisecondsSinceEpoch(value.timer!)
                  .millisecondsSinceEpoch) {
            third = value;
          }
        }
      }
    }

    if (first != null) lstX.add(first);
    if (second != null) lstX.add(second);
    if (third != null) lstX.add(third);
    print(":::::::::::::ASD::::::::::::::");
    print(lstX.length);

    return lstX;
  }

  @override
  Future<bool> clearAll() async {
    Dio dio = await dioConsts(true);

    try {
      var response = await dio.delete('${ConstString.baseUrl}draw/clear-all');
      print("Status Code : ${response.statusCode}");
      // print("Status Code : ${response.data.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data["data"].toString());
        if (response.data["data"] == null) {
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      print('the exception in insertions is  $e');
    }
    throw UnimplementedError();
  }

  @override
  Future<List<ModelSlider>> getSlider() async {
    List<ModelSlider> lst = [];
    Dio dio = await dioConsts(true);
    try {
      var response = await dio.get('${ConstString.baseUrl}slider');
      print("Status Code : ${response.statusCode}");
      print(response.data["data"].toString());
      if (response.data["data"] == null) {
      } else {
        List<dynamic> jsonList = response.data["data"];
        for (var element in jsonList) {
          lst.add(ModelSlider.fromMap(element));
        }
      }
    } catch (e, s) {
      print('Exception @DatabaseService/getSlider $e');
    }
    return lst;
  }

  /// End Section )(*&^%$#@!@#$%^&*()(*&^%$#@!@#@#$%^%$#@!!@#$%^&*!@
  @override
  Future<bool> completeDraw() {
    // TODO: implement completeDraw
    throw UnimplementedError();
  }

  @override
  Future<List<AppUser>> getRequests() async {
    throw UnimplementedError();
  }

  // @override
  // Future<String> getPayAuth() async {
  //   // addParticipant();
  //   String authToken = '';
  //   BaseOptions options = BaseOptions(
  //     // baseUrl: ConstString.payUrl,
  //     receiveDataWhenStatusError: true,
  //     // connectTimeout: Duration(minutes: 5), // 60 seconds
  //     // receiveTimeout: Duration(minutes: 5), // 60 seconds
  //   );
  //   Dio dio = Dio(options);
  //   dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  //   dio.options.headers['Content-Type'] = 'application/json';
  //   dio.options.headers['Accept'] = '*/*';
  //   // dio.options.headers['Host'] = '*';
  //   dio.options.headers['Content-Length'] = '*';
  //   // dio.options.headers['Connection'] = 'keep-alive';
  //   dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
  //   // isAuth
  //
  //   dio.options.followRedirects = false;
  //   dio.options.validateStatus = (status) {
  //     return true;
  //   };
  //   try {
  //     var response = await dio.post('https://Sof_Tech/paypro/uis',
  //         data: jsonEncode({
  //           "clientid": "uciGfoVkUV2BFpp",
  //           "clientsecret": "tbThMBFmX92Rc4s"
  //         }));
  //
  //     authToken = response.headers.value("token") ?? "";
  //     print("Status Code : ${response.statusCode}");
  //     print("TTTTT Token : $authToken}");
  //
  //     await payFunc(authToken);
  //   } catch (e, s) {
  //     print('Exception @PayPro/ Auth $e');
  //   }
  //   return authToken;
  // }

  @override
  Future<String> getPayAuth() async {
    // addParticipant();
    String authToken = '';
    BaseOptions options = BaseOptions(
      baseUrl: ConstString.payUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: Duration(minutes: 5), // 60 seconds
      // receiveTimeout: Duration(minutes: 5), // 60 seconds
    );
    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = '*/*';
    // dio.options.headers['Host'] = '*';
    dio.options.headers['Content-Length'] = '*';
    // dio.options.headers['Connection'] = 'keep-alive';
    dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    // isAuth

    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return true;
    };
    try {
      var response = await dio.post('/v2/ppro/auth',
          data: jsonEncode({
            "clientid": "uciGfoVkUV2BFpp",
            "clientsecret": "tbThMBFmX92Rc4s"
          }));

      authToken = response.headers.value("token") ?? "";
      print("Status Code : ${response.statusCode}");
      print("TTTTT Token : $authToken}");

      payFunc(authToken);
    } catch (e, s) {
      print('Exception @PayPro/ Auth $e');
    }
    return authToken;
  }

  @override
  Future<String> getPayCustomAuth() async {
    // addParticipant();
    String authToken = '';
    BaseOptions options = BaseOptions(
      baseUrl: ConstString.payCustomUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: Duration(minutes: 5), // 60 seconds
      // receiveTimeout: Duration(minutes: 5), // 60 seconds
    );
    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = '*/*';
    // dio.options.headers['Host'] = '*';
    // dio.options.headers['Content-Length'] = '*';
    // dio.options.headers['Connection'] = 'keep-alive';
    dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    // isAuth

    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return true;
    };
    try {
      var response = await dio.get('/auth');
      print(response.statusCode.toString());
      return response.data.toString();
    } catch (e, s) {
      print('Exception @PayPro/ Auth $e');
    }
    return "False";
  }

  @override
  Future<String> getPayCustomOrder(String orderId) async {
    // addParticipant();
    String authToken = '';
    BaseOptions options = BaseOptions(
      baseUrl: ConstString.payNewCustomUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: Duration(minutes: 5), // 60 seconds
      // receiveTimeout: Duration(minutes: 5), // 60 seconds
    );
    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: false, requestBody: true));

    DateTime dd = DateTime.now();
    DateTime ddPlus = dd.add(const Duration(days: 150));
    String dateDue = "${ddPlus.day}/${ddPlus.month}/${ddPlus.year}";
    String date = "${dd.day}/${dd.month}/${dd.year}";

    String name = GetStorage().read("name") ?? "";
    String email = GetStorage().read("email") ?? "";
    try {
      var response = await dio.post('/paypro/order',
          data: jsonEncode({
            "orderNum": orderId,
            "orderAmount": "5",
            "orderDueDate": dateDue,
            "issueDate": date,
            "customer": {
              "name": name,
              "email": email,
              "mobile": "",
              "address": ""
            }
          }));
      print(response.data.toString());

      print(response.data["checkout"].toString());
      print(response.data["_id"].toString());
      GetStorage().write("orderId", response.data["_id"].toString());
      payFuncCallback(response.data["checkout"].toString());

      return "";
    } catch (e, s) {
      GetStorage().write("orderId", "");
      // await getAllOrders();
      print('Exception @PayPro/ Custom Order $e');
    }
    return "False";
  }

  Future<void> getAllOrders() async {
    BaseOptions options = BaseOptions(
      baseUrl: ConstString.payNewCustomUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: Duration(minutes: 5), // 60 seconds
      // receiveTimeout: Duration(minutes: 5), // 60 seconds
    );
    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return true;
    };
String orderId= GetStorage().read("orderId");
    try {
      var response = await dio.get('/order');

      print(response.data.toString());


    } catch (e, s) {
      print('Exception @PayPro/ Custom Order $e');
    }
  }

  Future<bool> payFunc(String token) async {
    EasyLoading.show();
    BaseOptions options = BaseOptions(
      baseUrl: ConstString.payUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: Duration(minutes: 5), // 60 seconds
      // receiveTimeout: Duration(minutes: 5), // 60 seconds
    );
    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = '*/*';
    // dio.options.headers['Host'] = '*';
    dio.options.headers['Content-Length'] = '*';
    dio.options.headers['token'] = token;
    // dio.options.headers['Connection'] = 'keep-alive';
    dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    // isAuth

    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return true;
    };
    DateTime dd = DateTime.now();
    DateTime ddPlus = dd.add(const Duration(days: 150));
    String dateDue = "${ddPlus.day}/${ddPlus.month}/${ddPlus.year}";
    String date = "${dd.day}/${dd.month}/${dd.year}";

    String orderId = const Uuid().v1();
    try {
      var response = await dio.post('/v2/ppro/co',
          data: jsonEncode([
            {"MerchantId": "Sof_Tech"},
            {
              "OrderNumber": orderId,
              "OrderAmount": "5",
              "OrderDueDate": dateDue,
              "OrderType": "Service",
              "IssueDate": date,
              "OrderExpireAfterSeconds": "0",
              "CustomerName": GetStorage().read("name") ?? "Adnan",
              "CustomerMobile": "",
              "CustomerEmail": "",
              "CustomerAddress": ""
            }
          ]));

      print("Status Code : ${response.statusCode}");
      // print("Status Click2Pay : ${response.toString()}");
      // print("Status Click2Pay : ${response.toString()}");
      // print("Status Click2Pay : ${response.data[1].toString()}");
      print("Status Click2Pay : ${response.data[1]["Click2Pay"]}");

      //callOrders();
      // GetStorage().write("payToken", response.headers.value("token"));
      payFuncCallback(response.data[1]["Click2Pay"]);
    } catch (e, s) {
      print('Exception @PayPro/ Co $e');
    }
    EasyLoading.dismiss();
    return false;
  }

  payFuncCallback(String _url) async {
    try {
      final Uri url = Uri.parse(_url);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $_url');
      } else {
        // addParticipant();
      }

      //callOrders();
    } catch (e, s) {
      print('Exception @PayPro/ callback $e');
    }
  }

  @override
  Future<void> getPayBankAuth(ModelBank bankModel) async {
    String authToken = '';
    BaseOptions options = BaseOptions(
      baseUrl: ConstString.payUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: Duration(minutes: 5), // 60 seconds
      // receiveTimeout: Duration(minutes: 5), // 60 seconds
    );
    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = '*/*';
    // dio.options.headers['Host'] = '*';
    dio.options.headers['Content-Length'] = '*';
    // dio.options.headers['Connection'] = 'keep-alive';
    dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    // isAuth

    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return true;
    };
    try {
      var response = await dio.post('/v2/ppro/auth',
          data: jsonEncode({
            "clientid": "uciGfoVkUV2BFpp",
            "clientsecret": "tbThMBFmX92Rc4s"
          }));

      authToken = response.headers.value("token") ?? "";
      print("Status Code : ${response.statusCode}");
      print("TTTTT Token : $authToken}");

      // bankFunc(bankModel,authToken);
    } catch (e, s) {
      print('Exception @PayPro/ Auth $e');
    }
  }

  @override
  Future<void> callOrders() async {
    print("callOrders");
    Timer.periodic(const Duration(minutes: 1), (t) async {
      String orderId = GetStorage().read("orderId") ?? "";
      print("callOrders in loop : orderId => $orderId");
      while (orderId.isNotEmpty) {

        BaseOptions options = BaseOptions(
          baseUrl: ConstString.payNewCustomUrl,
          receiveDataWhenStatusError: true,
          // connectTimeout: Duration(minutes: 5), // 60 seconds
          // receiveTimeout: Duration(minutes: 5), // 60 seconds
        );
        Dio dio = Dio(options);
        dio.interceptors
            .add(LogInterceptor(responseBody: true, requestBody: true));

        try {
          var response = await dio.get('/order/$orderId');

          print("Status Code : ${response.statusCode}");
          print("Status Code : ${response.data}");

          if(response.data["status"] == "paid"){

            GetStorage().write("orderId", "");
          // await  addParticipant();
          sl<MainNavClientController>().getParticipants();
          }
          // bankFunc(bankModel,authToken);
        } catch (e, s) {
          print('Exception @PayPro/ Get Order $e');
        }
      }
    });
  }

  final _db = FirebaseFirestore.instance;

  @override
  Future<String> insertNewRequest(RequestModel requestModel) async {
    String message = '';
    try{
      await _db.collection('request').doc(requestModel.userUid).set(requestModel.toMap());
      print('Request has been Added');
      message = 'Success';

    }
    catch(e){
      print('the error in insertNewRequest in AdminDatabaseImpl  //////!!!!! is $e');
      message = 'the error in insertNewRequest in AdminDatabaseImpl $e';
    }

    return message;


  }



  @override
  Future<List<RequestModel>> getAllRequest(String uid) async{

    List<RequestModel> mdl = [];
    try{
      final snapshot = await _db.collection('request').orderBy('date',descending: false).get();
      for(var element in snapshot.docs){
        RequestModel mddl = RequestModel.fromMap(element.data());
        mdl.add(mddl);
      }
      print('Alll request length is ${mdl.length}');
    }
    catch(e){
      print('The errorr in getMyItems in AdminDatabaseImpl //##@@@ is $e');
    }

    return mdl;
  }




}

// Future<void> bankFunc(ModelBank bankModel, String authToken) async {
//   BaseOptions options =  BaseOptions(
//     baseUrl: ConstString.payUrl,
//     receiveDataWhenStatusError: true,
//     // connectTimeout: Duration(minutes: 5), // 60 seconds
//     // receiveTimeout: Duration(minutes: 5), // 60 seconds
//   );
//   Dio dio = Dio(options);
//   dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
//   dio.options.headers['Content-Type'] = 'application/json';
//   dio.options.headers['Accept'] = '*/*';
//   // dio.options.headers['Host'] = '*';
//   dio.options.headers['Content-Length'] = '*';
//   dio.options.headers['token'] = token;
//   // dio.options.headers['Connection'] = 'keep-alive';
//   dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
//   // isAuth
//
//
//
//   dio.options.followRedirects = false;
//   dio.options.validateStatus=(status) { return true; };
//   String dateDue = "${DateTime.now().add(const Duration(days: 150)).day}/${DateTime.now().add(const Duration(days: 150)).month}/${DateTime.now().add(const Duration(days: 150)).year}";
//   String date = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
//   try {
//     var response =
//         await dio.post('/v2/ppro/co', data: jsonEncode(
//         [
//           {
//             "MerchantId": "Soft_Tech"
//           },
//           {
//             "OrderNumber": const Uuid().v4(),
//             "OrderAmount": "5",
//             "OrderDueDate": dateDue,
//             "OrderType": "Service",
//             "IssueDate": date,
//             "OrderExpireAfterSeconds": "0",
//             "CustomerName": GetStorage().read("name")??"Adnan",
//             "CustomerMobile": phone,
//             "CustomerEmail": "",
//             "CustomerAddress": ""
//           }
//         ]
//     ));
//
//     print("Status Code : ${response.statusCode}");
//     print("TTTTT Token : ${response.headers.value("token")}");
//
//
//     GetStorage().write("payToken", response.headers.value("token"));
//   } catch (e, s) {
//     print('Exception @PayPro/ Auth $e');
//   }
//
// }

