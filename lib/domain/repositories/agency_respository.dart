import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';

abstract class AgencyRepository {
  Future<Either<ExceptionEntity, List<AgencyEntity>>> getAllAgents();
  Future<void> selectAgent(String agentId);
  Future<Either<ExceptionEntity, AgencyEntity?>> loadSelectedAgent();
}
