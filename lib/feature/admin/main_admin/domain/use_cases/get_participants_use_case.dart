import 'package:dartz/dartz.dart';
import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_participants.dart';
import '../repositories/admin_repository.dart';

class GetParticipantsUseCase
    implements UseCase<List<ModelParticipants>, NoParams> {
  final AdminRepository repository;

  GetParticipantsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ModelParticipants>>> call(NoParams params) async {
    return await repository.getParticipants();
  }
}
