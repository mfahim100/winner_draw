import 'package:dartz/dartz.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';
import '../entities/model_otp.dart';
import '../repositories/auth_repository.dart';


class ReSendOtpUseCase implements UseCase<bool, Params<ModelOTP>> {
  final AuthRepository repository;

  ReSendOtpUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.resendOtp(params.data);
  }
}
