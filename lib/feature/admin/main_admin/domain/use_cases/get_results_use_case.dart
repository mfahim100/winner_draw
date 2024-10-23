import 'package:dartz/dartz.dart';


import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_results.dart';
import '../repositories/admin_repository.dart';

class GetResultsUseCase implements UseCase<List<List<ModelResults>>, NoParams> {
  final AdminRepository repository;

  GetResultsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<List<ModelResults>>>> call(
      NoParams params) async {
    return await repository.getResults();
  }
}
