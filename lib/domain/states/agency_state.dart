import 'package:flutter/material.dart';
import 'package:samay/domain/entities/agency_entity.dart';

abstract class AgencyState with ChangeNotifier {
  abstract AgencyEntity? selectedAgency;
  abstract List<AgencyEntity> listOfAgencies;
  abstract ThemeData? theme;
}
