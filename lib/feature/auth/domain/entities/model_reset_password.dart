class ModelChangePassword {

  final  String? email;
  final  String? otp;
  final  String? newPassword;

  ModelChangePassword({
     this.email,
    this.otp,
    this.newPassword,
  });



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['email'] = email;
    data['otp'] = otp;
    data['newPassword'] = newPassword;



    return data;
  }
}