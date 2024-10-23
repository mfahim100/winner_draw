import 'package:dartz/dartz.dart';


import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_photos_comment.dart';
import '../repositories/admin_repository.dart';

class GetPhotoCommentsUseCase
    implements UseCase<List<ModelPhotoComments>, Params<String>> {
  final AdminRepository repository;

  GetPhotoCommentsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ModelPhotoComments>>> call(Params params) async {
    return await repository.getPhotoComments(params.data);
  }
}
