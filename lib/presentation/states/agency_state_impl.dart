import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/states/agency_state.dart';

class AgencyStateImpl extends AgencyState {
  AgencyEntity? _selectedAgency;
  @override
  AgencyEntity? get selectedAgency => _selectedAgency;

  @override
  set selectedAgency(AgencyEntity? value) {
    _selectedAgency = value;
    notifyListeners();
  }
  
}