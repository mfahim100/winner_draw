import 'package:dartz/dartz.dart';
import '../../../../../core/utils/failure.dart';
import '../../../../auth/domain/entities/app_user.dart';
import '../../domain/entities/model_participants.dart';
import '../../domain/entities/model_photos.dart';
import '../../domain/entities/model_photos_comment.dart';
import '../../domain/entities/model_prize.dart';
import '../../domain/entities/model_results.dart';
import '../../domain/entities/model_slider.dart';
import '../../domain/entities/request_model.dart';
import '../../domain/repositories/admin_repository.dart';
import '../data_sources/admin_database_main.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminMainDatabase remoteDatabase;

  AdminRepositoryImpl({required this.remoteDatabase});

  @override
  Future<Either<Failure, bool>> addLuckyDraw(ModelPrize prize) async {
    try {
      final result = await remoteDatabase.addCurrentLucyDraw(prize);
      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }




  @override
  Future<Either<Failure, bool>> updateLuckyDraw(ModelPrize prize) async {
    try {
      final result = await remoteDatabase.updateCurrentLucyDraw(prize);

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ModelPrize>>> getCurrentLuckyDraw() async {
    try {
      final result = await remoteDatabase.getCurrentLuckyDraw();

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }



  @override
  Future<Either<Failure, List<ModelPhotos>>> getPhotos() async {
    try {
      final result = await remoteDatabase.getPhotos();

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> clearAll() async {
    try {
      final result = await remoteDatabase.clearAll();

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }
  @override
  Future<Either<Failure, bool>> completeDraw() async {
    try {
      final result = await remoteDatabase.completeDraw();

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ModelSlider>>> getSlider() async {
        try {
      final result = await remoteDatabase.getSlider();

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ModelParticipants>>> getParticipants() async {
    try {
      final result = await remoteDatabase.getParticipants();

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addParticipants(String userId) async {
    try {
      final result = await remoteDatabase.addParticipant(userId);

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }
  @override
  Future<Either<Failure, bool>> deleteParticipants(String uid) async {
    try {
      final result = await remoteDatabase.deleteParticipant(uid);

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }
  // @override
  // Future<Either<Failure, ModelPhotos>> updatePhoto(File file) async {
  //   try {
  //     final result = await remoteDatabase.uploadPhoto(file);
  //
  //     return Right(result);
  //   } catch (error) {
  //     return Left(Failure(message: error.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, bool>> addPhoto(ModelPhotos photos) async {
    try {
      final result = await remoteDatabase.addPhotos(photos);

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> likeDislike(ModelPhotos photos) async {
    try {
      final result = await remoteDatabase.likeDislike(photos);

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addPhotoComment(ModelPhotoComments comment) async {
    try {
      final result = await remoteDatabase.addPhotoComments(comment);

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ModelPhotoComments>>> getPhotoComments(String pid) async {
    try {
      final result = await remoteDatabase.getPhotoComments(pid);

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePhoto(ModelPhotos photos) async {
    try {
      final result = await remoteDatabase.deletePhoto(photos);

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<List<ModelResults>>>> getResults() async {
    try {
      final result = await remoteDatabase.getResults();

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ModelResults>>> getCurrentResults() async {
    try {
      final result = await remoteDatabase.getCurrentResults();
      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }

  }

  @override
  Future<Either<Failure, List<AppUser>>> getRequests() async {
    try {
      final result = await remoteDatabase.getRequests();

      return Right(result);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> insertNewRequest(RequestModel requestModel) async  {
    String  isRegister= await  remoteDatabase.insertNewRequest(requestModel);
    if(isRegister=='Success'){
      return const Right(true);
    }
    else {
      return Left(Failure(message: isRegister));
    }
  }

  @override
  Future<Either<Failure, List<RequestModel>>> getAllRequest(String uid) async  {
    List<RequestModel>   requests = await  remoteDatabase.getAllRequest(uid);
    if(requests != null){
      print("repo : ${requests.length}");
      return  Right(requests);
    }
    else {
      print('the eroor in getAllRequest in AdminRepoImpl is @@@@@@@@@@@@ ////////////@@@@@@ ');
      return Left(Failure(message: "Something went wrong"));
    }
  }


}
