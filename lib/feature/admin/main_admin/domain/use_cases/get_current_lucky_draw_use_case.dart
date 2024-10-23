import 'package:dartz/dartz.dart';

import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_prize.dart';
import '../repositories/admin_repository.dart';

class GetCurrentLuckyDrawUseCase
    implements UseCase<List<ModelPrize>, NoParams> {
  final AdminRepository repository;

  GetCurrentLuckyDrawUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ModelPrize>>> call(NoParams params) async {
    return await repository.getCurrentLuckyDraw();
  }
}
