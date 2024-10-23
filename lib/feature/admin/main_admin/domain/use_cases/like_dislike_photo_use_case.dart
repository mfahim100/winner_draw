import 'package:dartz/dartz.dart';


import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_photos.dart';
import '../repositories/admin_repository.dart';



class LikeDislikePhotoUseCase implements UseCase<bool, Params<ModelPhotos>> {
  final AdminRepository repository;

  LikeDislikePhotoUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.likeDislike(params.data);
  }
}
