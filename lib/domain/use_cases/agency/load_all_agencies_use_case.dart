import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/agency_respository.dart';
import 'package:samay/domain/states/agency_state.dart';

class LoadAllAgenciesUseCase {
  final AgencyRepository agencyRepository;
  final AgencyState agencyState;

  LoadAllAgenciesUseCase({
    required this.agencyRepository,
    required this.agencyState,
  });

  Future<Either<ExceptionEntity, List<AgencyEntity>>> call() async {
    final response = await agencyRepository.getAllAgents();
    if (response.isLeft) {
      return Left(response.left);
    }
    agencyState.listOfAgencies = response.right;
    return Right(response.right);
  }
}
