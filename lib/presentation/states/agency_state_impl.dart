import 'package:flutter/material.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/presentation/ui/theme/light_theme.dart';

class AgencyStateImpl extends AgencyState {
  AgencyEntity? _selectedAgency;
  @override
  AgencyEntity? get selectedAgency => _selectedAgency;

  @override
  set selectedAgency(AgencyEntity? value) {
    _selectedAgency = value;
    _setThemeBasedOnAgency(value);
    notifyListeners();
  }

  List<AgencyEntity> _listOfAgencies = [];
  @override
  List<AgencyEntity> get listOfAgencies => _listOfAgencies;

  @override
  set listOfAgencies(List<AgencyEntity> value) {
    _listOfAgencies = value;
    notifyListeners();
  }

  ThemeData? _theme;
  @override
  ThemeData? get theme => _theme;
  @override
  set theme(ThemeData? value) {
    _theme = value;
    notifyListeners();
  }

  void _setThemeBasedOnAgency(AgencyEntity? agency) {
    if (agency == null) {
      theme = lightTheme();
      return;
    }
    Color color = Color(int.parse('0xFF${agency.hexColor}'));
    _theme = lightTheme(colorMain: color);
  }
}
