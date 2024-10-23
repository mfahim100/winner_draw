import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';


import '../../../../core/utils/failure.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/model_otp.dart';
import '../../domain/entities/model_reset_password.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/database_main.dart';

class AuthRepositoryImpl implements AuthRepository {
  final MainDatabase remoteDatabase;

  AuthRepositoryImpl({required this.remoteDatabase});

  @override
  Future<Either<Failure, bool>> registerUser(AppUser user) async {
    try {

      final response = await remoteDatabase.registerUser(user);

      print("in Registerrrrrrrrrrrrrr");
      print("${response.data["error"]}");

      if(response.statusCode == 200 ||response.statusCode == 201){
        print(response.data["data"].toString());
        if(response.data["data"] == null){
          return Left(Failure(message: response.data["error"].toString()));
        }
      }

      else if (response.statusCode == 400){
        return Left(Failure(message: response.data["error"].toString()));
      }
      else if (response.statusCode == 500){
        if(response.data["error"].toString().contains("email_1 dup key")){
          return Left(Failure(message: "Email Already Exists"));
        }else{

          return Left(Failure(message: response.data["error"].toString()));
        }

      }
      return const Right(true);
    }

    catch (error) {
      print('the quick brown fox jumps over the lazy dog');
      print('erorrrrrrrrrrrrrrrrr ___________ $error');
      if(user.file == null){
        return Left(Failure(message: "Please select profile image"));
      }
      return Left(Failure(message: error.toString()));
    }
  }



  // Future<Either<Failure, AppUser?>> loginUser(AppUser user) async {
  //   try {
  //     final result = await remoteDatabase.loginWithEmailPassword(user.email!,user.password!);
  //     return Right(result);
  //   } catch (error) {
  //     return Left(Failure(message: error.toString()));
  //   }
  // }
  @override
  Future<Either<Failure, AppUser>> loginUser(AppUser user) async {
    try {
      final response = await remoteDatabase.loginWithEmailPassword(user);

      print("in repositoryyyyyy");
      print("${response.data["error"]}");

      if(response.statusCode == 200 ||response.statusCode == 201){

        print(response.data["data"].toString());
        if(response.data["data"] == null){
          return Left(Failure(message: response.data["error"].toString()));
        }else{
          AppUser user=AppUser.fromJson(response.data["data"]);
          print(user.token);
          GetStorage().write("token", user.token);
          GetStorage().write("isLogin", true);
          GetStorage().write("UserId", user.uid);
          GetStorage().write("name", user.name);
          return  Right(user);
        }
      }else if (response.statusCode == 400 || response.statusCode == 401){
        return Left(Failure(message: response.data["error"].toString()));

      }


      return Left(Failure(message: "Something went wrong"));
    } catch (error) {
      print('the quick brown fox jumps over the lazy dog');
      print('erorrrrrrrrrrrrrrrrr ___________ $error');
      return Left(Failure(message: error.toString()));
    }
  }



  @override
  Future<Either<Failure, AppUser?>> getUser(String uid) async {
    try {
      final result = await remoteDatabase.getUser(uid);

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppUser>>> getAllUser() async {
    try {
      final result = await remoteDatabase.getAllUser();

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> forgetPass(AppUser user) async {
    try {
      final response = await remoteDatabase.forgetPass(user);

      print("in Forgot Pasworddddddddd");
      print("${response.data["error"]}");

      if(response.statusCode == 200 ||response.statusCode == 201){

        print(response.data["data"].toString());
        if(response.data["data"] == null){
          return Left(Failure(message: response.data["error"].toString()));
        }


      }else if (response.statusCode == 400 ||response.statusCode == 404){
        return Left(Failure(message: response.data["error"].toString()));

      }

      return const Right(true);
    } catch (error) {
      print('the quick brown fox jumps over the lazy dog');
      print('erorrrrrrrrrrrrrrrrr ___________ $error');
      return Left(Failure(message: error.toString()));
    }
  }
  // Future<Either<Failure, bool>> forgetPass(String email) {
  //   // TODO: implement forgetPass
  //   throw UnimplementedError();
  // }

  @override
  Future<Either<Failure, bool>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> resendOtp(ModelOTP mdl) async {
    try {
      final response = await remoteDatabase.resendOtp(mdl);

      print("in repositoryyyyyy");
      print("${response.data["error"]}");

      if(response.statusCode == 200 ||response.statusCode == 201){

        print(response.data["data"].toString());
        if(response.data["data"] == null){
          return Left(Failure(message: response.data["error"].toString()));
        }


      }

      return const Right(true);
    } catch (error) {
      print('the quick brown fox jumps over the lazy dog');
      print('erorrrrrrrrrrrrrrrrr ___________ $error');
      return Left(Failure(message: error.toString()));
    }
  }


  @override
  Future<Either<Failure, bool>> changePassword(ModelChangePassword mdl) async {
    try {
      final response = await remoteDatabase.changePassword(mdl);

      print("in Paswordddddddddd");
      print("${response.data["error"]}");
      if(response.statusCode == 200 ||response.statusCode == 201){
        print(response.data["data"].toString());
        if(response.data["data"] == null){
          return Left(Failure(message: response.data["error"].toString()));
        }
      }

      return const Right(true);
    } catch (error) {
      print('the quick brown fox jumps over the lazy dog');
      print('erorrrrrrrrrrrrrrrrr ___________ $error Password changing');
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUser(AppUser user) async {
    try {
      final response = await remoteDatabase.updateUser(user);

      print("in Registerrrrrrrrrrrrrr");
      print("${response.data["error"]}");

      if(response.statusCode == 200 ||response.statusCode == 201){

        print(response.data["data"].toString());
        if(response.data["data"] == null){
          return Left(Failure(message: response.data["error"].toString()));
        }
      }

      return const Right(true);
    } catch (error) {
      print('the quick brown fox jumps over the lazy dog');
      print('erorrrrrrrrrrrrrrrrr ___________ $error');
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(ModelOTP mdl) async {
    try {
      final response = await remoteDatabase.verifyOtp(mdl);

      print("in repositoryyyyyy");
      print("${response.data["error"]}");

      if(response.statusCode == 200 ||response.statusCode == 201){

        print(response.data["data"].toString());
        if(response.data["data"] == null){
          return Left(Failure(message: response.data["error"].toString()));
        }


      }

      return const Right(true);
    } catch (error) {
      print('the quick brown fox jumps over the lazy dog');
      print('erorrrrrrrrrrrrrrrrr ___________ $error');
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> passOtp(ModelOTP mdl) async {
    try {
      final response = await remoteDatabase.passOtp(mdl);

      print("in repositoryyyyyy");
      print("${response.data["error"]}");

      if(response.statusCode == 200 ||response.statusCode == 201){

        print(response.data["data"].toString());
        if(response.data["data"] == null){
          return Left(Failure(message: response.data["error"].toString()));
        }else{

          return const Right(true);
        }


      }

      return const Right(true);
    } catch (error) {
      print('the quick brown fox jumps over the lazy dog');
      print('erorrrrrrrrrrrrrrrrr ___________ $error');
      return Left(Failure(message: error.toString()));
    }
  }

}
