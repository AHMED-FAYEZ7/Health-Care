import 'package:dartz/dartz.dart';
import 'package:health_care/core/error/failure.dart';
import 'package:health_care/core/usecase/base_usecase.dart';
import 'package:health_care/patient/domain/model/patient_entities.dart';
import 'package:health_care/patient/domain/repository/patient_repo.dart';

class GetDoctorsSpecializationUseCase
    implements BaseUseCase<String, DoctorInfo> {
  final BasePatientRepo _basePatientRepo;

  GetDoctorsSpecializationUseCase(this._basePatientRepo);

  @override
  Future<Either<Failure, DoctorInfo>> call(String input) async {
    return await _basePatientRepo.getDoctorsSpecialization(input);
  }
}
