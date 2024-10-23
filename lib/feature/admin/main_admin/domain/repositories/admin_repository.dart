import 'package:dartz/dartz.dart';
import '../../../../../core/utils/failure.dart';
import '../../../../auth/domain/entities/app_user.dart';
import '../entities/model_participants.dart';
import '../entities/model_photos.dart';
import '../entities/model_photos_comment.dart';
import '../entities/model_prize.dart';
import '../entities/model_results.dart';
import '../entities/model_slider.dart';
import '../entities/request_model.dart';




abstract class AdminRepository{


  Future<Either<Failure,bool>> addLuckyDraw(ModelPrize user);
  Future<Either<Failure,bool>> updateLuckyDraw(ModelPrize user);
  Future<Either<Failure,List<ModelPrize>>> getCurrentLuckyDraw();
  Future<Either<Failure,List<ModelSlider>>> getSlider();
  Future<Either<Failure,bool>> clearAll();
  Future<Either<Failure,bool>> completeDraw();

  Future<Either<Failure,List<ModelParticipants>>> getParticipants();
  Future<Either<Failure,bool>> addParticipants(String userId);
  Future<Either<Failure,bool>> deleteParticipants(String uid);

  Future<Either<Failure,bool>> addPhoto(ModelPhotos photos);
  // Future<Either<Failure,ModelPhotos>> updatePhoto(File file);
  Future<Either<Failure,List<ModelPhotos>>> getPhotos();
  Future<Either<Failure,bool>> likeDislike(ModelPhotos photos);
  Future<Either<Failure,bool>> addPhotoComment(ModelPhotoComments comment);
  Future<Either<Failure,List<ModelPhotoComments>>> getPhotoComments(String pid);
  Future<Either<Failure,bool>> deletePhoto(ModelPhotos photos);


  Future<Either<Failure,List<List<ModelResults>>>> getResults();
  Future<Either<Failure,List<ModelResults>>> getCurrentResults();
  Future<Either<Failure,List<AppUser>>> getRequests();

  Future<Either<Failure,bool>> insertNewRequest(RequestModel requestModel);
  Future<Either<Failure,List<RequestModel>>> getAllRequest(String uid);




}