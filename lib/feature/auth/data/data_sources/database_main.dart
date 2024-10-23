



import 'package:dio/dio.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/model_otp.dart';
import '../../domain/entities/model_reset_password.dart';

abstract class MainDatabase{


  Future<Response> registerUser(AppUser user);
  Future<Response> updateUser(AppUser user);
  Future<AppUser?> getUser(String uid);
  Future<List<AppUser>> getAllUser();
  // Future<AppUser?> loginWithEmailPassword(String email,String pass);
  Future<Response> loginWithEmailPassword(AppUser user);
  Future<Response> forgetPass(AppUser user);
  Future<Response> resendOtp(ModelOTP mdl);
  Future<Response> verifyOtp(ModelOTP mdl);
  Future<Response> passOtp(ModelOTP mdl);
  Future<Response> changePassword(ModelChangePassword mdl);





}