import 'package:dartz/dartz.dart';


import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_photos_comment.dart';
import '../repositories/admin_repository.dart';



class AddPhotoCommentsUseCase implements UseCase<bool, Params<ModelPhotoComments>> {
  final AdminRepository repository;

  AddPhotoCommentsUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.addPhotoComment(params.data);
  }
}
