import 'package:dartz/dartz.dart';

import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../../../../auth/domain/entities/app_user.dart';
import '../repositories/admin_repository.dart';

class GetRequestUseCase implements UseCase<List<AppUser>, NoParams> {
  final AdminRepository repository;

  GetRequestUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AppUser>>> call(
      NoParams params) async {
    return await repository.getRequests();
  }
}
