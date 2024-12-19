import 'package:either_dart/either.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/entities/search_result_entity.dart';

abstract class AgentRepository {
  Future<Either<ExceptionEntity, SearchResultEntity<AgencyEntity>>>
      searchAgents(
          {required String searchWord,
          required int page,
          required int itemsPerPage});
  Future<void> selectAgent(String agentId);
  Future<Either<ExceptionEntity, AgencyEntity?>> loadSelectedAgent();
}
