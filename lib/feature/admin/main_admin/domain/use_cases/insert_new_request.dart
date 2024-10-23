import 'package:dartz/dartz.dart';

import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../repositories/admin_repository.dart';


class InsertNewRequestUseCase implements UseCase{




  final AdminRepository adminRepository;

  InsertNewRequestUseCase({required this.adminRepository});

  @override
  Future<Either<Failure, dynamic>> call(params) async {
    return await adminRepository.insertNewRequest(params.data);
  }





}