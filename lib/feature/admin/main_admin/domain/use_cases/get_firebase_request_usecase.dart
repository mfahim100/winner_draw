import 'package:dartz/dartz.dart';


import '../../../../../core/utils/failure.dart';
import '../../../../../core/utils/use_case.dart';
import '../repositories/admin_repository.dart';

class GetFirebaseRequestUseCase implements UseCase{


  final AdminRepository adminRepository;

  GetFirebaseRequestUseCase({required this.adminRepository});
  @override


  Future<Either<Failure, dynamic>> call(params) async {
    return await adminRepository.getAllRequest(params.data);
  }




}