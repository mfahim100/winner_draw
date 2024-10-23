import 'package:dartz/dartz.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';


class GetUserUseCase implements UseCase<AppUser?, Params<String>> {
  final AuthRepository repository;

  GetUserUseCase({required this.repository});

  @override
  Future<Either<Failure, AppUser?>> call(Params params) async {
    return await repository.getUser(params.data);
  }
}
