import 'package:flutter/material.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/presentation/ui/theme/light_theme.dart' as lt;
import 'package:samay/presentation/ui/theme/dark_theme.dart' as dt;

class AgencyStateImpl extends AgencyState {
  AgencyEntity? _selectedAgency;
  @override
  AgencyEntity? get selectedAgency => _selectedAgency;

  @override
  set selectedAgency(AgencyEntity? value) {
    _selectedAgency = value;
    _setLightThemeBasedOnAgency(value);
    _setDarkThemeBasedOnAgency(value);
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

  ThemeData? _lightTheme;
  @override
  ThemeData? get lightTheme => _lightTheme;
  @override
  set lightTheme(ThemeData? value) {
    _lightTheme = value;
    notifyListeners();
  }

  void _setLightThemeBasedOnAgency(AgencyEntity? agency) {
    if (agency == null) {
      lightTheme = lt.lightTheme();
      return;
    }
    Color color = Color(int.parse('0xFF${agency.hexColor}'));
    _lightTheme = lt.lightTheme(colorMain: color);
  }

  ThemeData? _darkTheme;
  @override
  ThemeData? get darkTheme => _darkTheme;
  @override
  set darkTheme(ThemeData? value) {
    _darkTheme = value;
    notifyListeners();
  }

  void _setDarkThemeBasedOnAgency(AgencyEntity? agency) {
    if (agency == null) {
      darkTheme = dt.darkTheme();
      return;
    }
    Color color = Color(int.parse('0xFF${agency.hexColor}'));
    _darkTheme = dt.darkTheme(colorMain: color);
  }
}
