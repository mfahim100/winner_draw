import 'package:dartz/dartz.dart';


import '../../../../core/utils/failure.dart';
import '../entities/app_user.dart';
import '../entities/model_otp.dart';
import '../entities/model_reset_password.dart';


abstract class AuthRepository{


  Future<Either<Failure,bool>> registerUser(AppUser user);
  Future<Either<Failure,bool>> updateUser(AppUser user);
  Future<Either<Failure,AppUser>> loginUser(AppUser user);
  Future<Either<Failure,bool>> logout();
  Future<Either<Failure,bool>> forgetPass(AppUser user);
  Future<Either<Failure,bool>> changePassword(ModelChangePassword mdl);
  Future<Either<Failure,bool>> resendOtp(ModelOTP mdl);
  Future<Either<Failure,bool>> verifyOtp(ModelOTP mdl);
  Future<Either<Failure,bool>> passOtp(ModelOTP mdl);
  Future<Either<Failure,AppUser?>> getUser(String uid);
  Future<Either<Failure,List<AppUser>>> getAllUser();

}