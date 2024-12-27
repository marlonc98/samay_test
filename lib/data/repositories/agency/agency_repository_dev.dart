import 'package:either_dart/either.dart';
import 'package:samay/data/repositories/agency/agency_repository_fake.dart';
import 'package:samay/data/repositories/agency/api/get_all_agents_api_impl.dart';
import 'package:samay/data/repositories/agency/api/get_selected_agent_api_impl.dart';
import 'package:samay/data/repositories/agency/api/select_agent_api_impl.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/agency_respository.dart';

class AgencyRepositoryDev extends AgencyRepository {
  String selectedAgencySPKey = 'selectedAgencySPKey';
  AgencyRepositoryFake agencyRepositoryFake = AgencyRepositoryFake();
  @override
  Future<Either<ExceptionEntity, List<AgencyEntity>>> getAllAgents() =>
      getAllAgentsApiImpl();

  @override
  Future<Either<ExceptionEntity, AgencyEntity?>> loadSelectedAgent() =>
      getSelectedAgentApiImpl(selectedAgencySPKey);

  @override
  Future<void> selectAgent(String agentId) =>
      selectAgentApiImpl(spKey: selectedAgencySPKey, agentId: agentId);
}
