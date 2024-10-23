import 'package:dartz/dartz.dart';

import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../repositories/admin_repository.dart';



class AddParticipantUseCase implements UseCase<bool, NoParams> {
  final AdminRepository repository;

  AddParticipantUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.addParticipants(params.toString());
  }
}
