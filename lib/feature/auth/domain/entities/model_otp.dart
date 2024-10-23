class ModelOTP {
 final  String email;
 final  String? newPassword;
 final  int? otpCode;


  ModelOTP( { this.newPassword,required this.email,  this.otpCode});


 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['otpCode'] = otpCode??0;

  data['email'] = email;
  data['newPassword'] = newPassword??"";



  return data;
 }
}
