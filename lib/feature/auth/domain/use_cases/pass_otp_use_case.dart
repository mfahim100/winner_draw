import 'package:dartz/dartz.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';
import '../entities/model_otp.dart';
import '../repositories/auth_repository.dart';


class PassOtpUseCase implements UseCase<bool, Params<ModelOTP>> {
  final AuthRepository repository;

  PassOtpUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.passOtp(params.data);
  }
}
