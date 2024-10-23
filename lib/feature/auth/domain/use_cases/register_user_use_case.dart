import 'package:dartz/dartz.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';


class RegisterUserUseCase implements UseCase<bool, Params<AppUser>> {
  final AuthRepository repository;

  RegisterUserUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.registerUser(params.data);
  }
}
