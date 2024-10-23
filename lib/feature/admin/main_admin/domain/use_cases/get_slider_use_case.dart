import 'package:dartz/dartz.dart';


import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/model_slider.dart';
import '../repositories/admin_repository.dart';

class GetSliderUseCase
    implements UseCase<List<ModelSlider>, NoParams> {
  final AdminRepository repository;

  GetSliderUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ModelSlider>>> call(NoParams params) async {
    return await repository.getSlider();
  }
}
