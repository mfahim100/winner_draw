import 'package:dartz/dartz.dart';


import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_results.dart';
import '../repositories/admin_repository.dart';

class GetCurrentResultsUseCase implements UseCase<List<ModelResults>, NoParams> {
  final AdminRepository repository;

  GetCurrentResultsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ModelResults>>> call(
      NoParams params) async {
    return await repository.getCurrentResults();
  }
}
