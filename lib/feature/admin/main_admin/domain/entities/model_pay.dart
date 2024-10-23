import 'dart:io';

import 'package:dio/dio.dart';

class ModelPay {

  String? amount;


  ModelPay({
    this.amount,

  });


  ModelPay.fromMap(Map<String, dynamic> json) {
    amount = json['amount']??"0";


  }
  formData() async {
    FormData formData = FormData.fromMap({

      // 'amount' : amount,
      // 'description' : millis,
      // 'uamount' : uamount,
      // 'imgUrl' : await  MultipartFile.fromFile(file!.path, filename: DateTime.now().millisecondsSinceEpoch.toString()),
      // 'title' : description,
      // 'status' : status,
      // 'like' : like,
      // 'comment' : comment,

    });

    return formData;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;


    return data;
  }
  Map<String, dynamic> toJsonApi() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;

    return data;
  }
  ModelPay copyWith({

    String? amount,

  }) {
    return ModelPay(
      amount: amount ?? this.amount,

    );
  }
}
