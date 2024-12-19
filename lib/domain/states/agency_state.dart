import 'package:flutter/foundation.dart';
import 'package:samay/domain/entities/agency_entity.dart';

abstract class AgencyState with ChangeNotifier {
  abstract AgencyEntity? selectedAgency;
}