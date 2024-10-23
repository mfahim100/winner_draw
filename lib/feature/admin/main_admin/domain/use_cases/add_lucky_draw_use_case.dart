import 'package:dartz/dartz.dart';

import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_prize.dart';
import '../repositories/admin_repository.dart';



class AddLuckyDrawUseCase implements UseCase<bool, Params<ModelPrize>> {
  final AdminRepository repository;

  AddLuckyDrawUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.addLuckyDraw(params.data);
  }
}
