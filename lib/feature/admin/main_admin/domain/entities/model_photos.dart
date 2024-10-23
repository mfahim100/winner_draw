import 'dart:io';

import 'package:dio/dio.dart';

class ModelPhotos {

  String? id;
  String? description;
  String? imgUrl;
  int? status;
  int? like;
  int? comment;
  String? millis;
  String? uid;
  File? file;

  ModelPhotos({
    this.id,
this.description,
    this.status,
    this.imgUrl,
    this.millis,
    this.uid,
    this.like,
    this.file,
    this.comment,
  });


  ModelPhotos.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    millis = json['description'];
    description = json['title'];

    status = json['status']??0;
    imgUrl = json['imgUrl'];
    uid = json['uid']??"";
    like = json['like']??0;
    comment = json['comment']??0;

  }
  formData() async {
    FormData formData = FormData.fromMap({

      // 'id' : id,
      'description' : millis,
      // 'uid' : uid,
      'imgUrl' : await  MultipartFile.fromFile(file!.path, filename: DateTime.now().millisecondsSinceEpoch.toString()),
      'title' : description,
      // 'status' : status,
      // 'like' : like,
      // 'comment' : comment,

    });

    return formData;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = millis;
    data['title'] = description;
    data['uid'] = uid;
    data['imgUrl'] = imgUrl;
    data['status'] = status;
    data['like'] = like;
    data['comment'] = comment;

    return data;
  }
  Map<String, dynamic> toJsonApi() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = uid;
    data['post'] = id;

    return data;
  }
  ModelPhotos copyWith({
    String? imgUrl,
    String? description,
    String? millis,
    String? id,
    int? status,
    int? like,
    int? comment,
    String? uid,
    File? file,
  }) {
    return ModelPhotos(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
      millis: millis ?? this.millis,
      status: status ?? this.status,
      like: like ?? this.like,
      comment: comment ?? this.comment,
      file: file ?? this.file,
    );
  }
}
