import 'package:either_dart/src/either.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/entities/exception_entity.dart';
import 'package:samay/domain/repositories/agency_respository.dart';

class AgencyRepositoryDev extends AgencyRepository {
  String selectedAgencySPKey = 'selectedAgencySPKey';
  @override
  Future<Either<ExceptionEntity, List<AgencyEntity>>> getAllAgents() {
    // TODO: implement getAllAgents
    throw UnimplementedError();
  }

  @override
  Future<ThemeData> getThemeFromAgency(AgencyEntity? agency) {
    // TODO: implement getThemeFromAgency
    throw UnimplementedError();
  }

  @override
  Future<Either<ExceptionEntity, AgencyEntity?>> loadSelectedAgent() {
    // TODO: implement loadSelectedAgent
    throw UnimplementedError();
  }

  @override
  Future<void> selectAgent(String agentId) {
    // TODO: implement selectAgent
    throw UnimplementedError();
  }
}
