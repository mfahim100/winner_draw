import 'package:dartz/dartz.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';


class ForgetUseCase implements UseCase<bool, Params<String>> {
  final AuthRepository repository;

  ForgetUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.forgetPass(params.data);
  }
}
