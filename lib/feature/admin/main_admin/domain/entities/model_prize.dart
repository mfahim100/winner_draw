import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ModelPrize {
  String? id;
  String? title; //
  int? price; //
  String? description;
  int? timer;
  String? imgUrl; //
  int? status;
  int? no; //
  String? uid;
  String? openAt;
  String? createdAt;
  String? updatedAt;
  File? file;

  ModelPrize({
    this.id,
    this.price,
    this.description,
    this.timer,
    this.status,
    this.imgUrl,
    this.title,
    this.uid,
    this.no,
    this.openAt,
    this.createdAt,
    this.updatedAt,
    this.file,
  });

  ModelPrize.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    no = json['drawNumber'] == "First"
        ? 1
        : json['drawNumber'] == "Second"
            ? 2
            : 3;
    price = int.parse(json['price']);
    title = json['title'];
    var dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
        .parseUTC(json['openAt'])
        .toLocal();

    timer = DateTime(dateValue.year, dateValue.month, dateValue.day,
        dateValue.hour, dateValue.minute)
        .millisecondsSinceEpoch;
    status = json['status'] == "active" ? 0 : 1;
    imgUrl = json['imgUrl'];
    uid = json['uid'];
    description = json['description'];
    openAt = json['openAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    
    if(no == 1){
      GetStorage().write("drawId", id);
      GetStorage().write("drawId1", id);
    } if(no == 2){
      GetStorage().write("drawId2", id);
    } if(no == 3){
      GetStorage().write("drawId3", id);
    }
  }

  formData() async {
    DateTime dt=DateTime.fromMillisecondsSinceEpoch(timer!).subtract(DateTime.now().timeZoneOffset);
    var dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
        .format(dt);

    FormData formData = FormData.fromMap({

      'id' : id,
      'drawNumber' :
      no == 1?"First":
      no == 2?"Second":"Third"
      ,

      'uid' : uid,
      'imgUrl' :await  MultipartFile.fromFile(file!.path, filename: DateTime.now().millisecondsSinceEpoch.toString()),
      'title' : title,
      'price' : price,
      'openAt' : dateValue.toString(),
      'status' : "active",
      'description' : description,

      'createdAt' : createdAt,
      'updatedAt' : updatedAt,
    });

    return formData;
  }
  Future<Map<String, dynamic>> toJson()  async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['drawNumber'] =
    no == 1?"First":
    no == 2?"Second":"Third"
    ;

    data['uid'] = uid;
    data['imgUrl'] =imgUrl;
    data['title'] = title;
    data['price'] = price;
    data['openAt'] = DateTime.fromMillisecondsSinceEpoch(timer!).toString();
    data['status'] = "active";
    data['description'] = description;

    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;


    return data;
  }

  ModelPrize copyWith({
    int? price,
    String? imgUrl,
    int? timer,
    String? description,
    String? title,
    String? id,
    int? status,
    int? no,
    String? uid,
    String? openAt,
    String? createdAt,
    String? updatedAt,
    File? file,
  }) {
    return ModelPrize(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      timer: timer ?? this.timer,
      description: description ?? this.description,
      title: title ?? this.title,
      status: status ?? this.status,
      no: no ?? this.no,
      openAt: openAt ?? this.openAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      file: file ?? this.file,
    );
  }
}
