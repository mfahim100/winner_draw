import 'package:dartz/dartz.dart';


import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_photos.dart';
import '../repositories/admin_repository.dart';

class GetPhotosUseCase
    implements UseCase<List<ModelPhotos>, NoParams> {
  final AdminRepository repository;

  GetPhotosUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ModelPhotos>>> call(NoParams params) async {
    return await repository.getPhotos();
  }
}
