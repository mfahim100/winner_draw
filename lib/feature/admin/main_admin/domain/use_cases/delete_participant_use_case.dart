import 'package:dartz/dartz.dart';

import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../repositories/admin_repository.dart';



class DeleteParticipantUseCase implements UseCase<bool, Params<String>> {
  final AdminRepository repository;

  DeleteParticipantUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.deleteParticipants(params.data);
  }
}
