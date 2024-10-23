
import '../../../../auth/domain/entities/app_user.dart';
import '../../../../auth/domain/entities/model_bank.dart';
import '../../domain/entities/model_participants.dart';
import '../../domain/entities/model_photos.dart';
import '../../domain/entities/model_photos_comment.dart';
import '../../domain/entities/model_prize.dart';
import '../../domain/entities/model_results.dart';
import '../../domain/entities/model_slider.dart';
import '../../domain/entities/request_model.dart';

abstract class AdminMainDatabase{


  Future<bool> addCurrentLucyDraw(ModelPrize prize);
  Future<bool> updateCurrentLucyDraw(ModelPrize prize);
  Future<List<ModelPrize>> getCurrentLuckyDraw();
  Future<List<ModelPhotos>> getPhotos();
  Future<bool> addPhotos(ModelPhotos photos);
  Future<List<ModelSlider>> getSlider();
  Future<List<ModelParticipants>> getParticipants();
  Future<bool> clearAll();
  Future<bool> completeDraw();
  Future<bool> addParticipant(String uersId);
  Future<bool> deleteParticipant(String uid);
  Future<bool> likeDislike(ModelPhotos photos);
  Future<ModelPhotos> getLikesComments(ModelPhotos photos);
  Future<bool> addPhotoComments(ModelPhotoComments comment);
  Future<List<ModelPhotoComments>> getPhotoComments(String pid);
  Future<bool> deletePhoto(ModelPhotos photos);
  Future<List<List<ModelResults>>> getResults( );
  Future<List<ModelResults>> getCurrentResults( );
  Future<List<AppUser>> getRequests( );
  // Future<String> profileImage(File file);
  Future<String> getPayAuth();
  Future<String> getPayCustomAuth();
  Future<String> getPayCustomOrder(String orderId);
  Future<void> getPayBankAuth(ModelBank bankModel);
  Future<void> callOrders();
  Future<String> insertNewRequest(RequestModel requestModel);
  Future<List<RequestModel>> getAllRequest(String uid);



}