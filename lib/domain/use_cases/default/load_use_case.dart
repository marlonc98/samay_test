import 'package:get_it/get_it.dart';
import 'package:samay/data/db/db_scheme.dart';
import 'package:samay/data/db/db_setting.dart';
import 'package:samay/domain/repositories/agency_respository.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';
import 'package:samay/domain/repositories/localization_repository.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/domain/states/domotic_state.dart';
import 'package:samay/domain/states/localization_state.dart';

class LoadUseCase {
  final LocalizationRepository localizationRepository;
  final LocalizationState localizationState;
  final AgencyRepository agencyRepository;
  final AgencyState agencyState;
  final DomoticRepository domoticRepository;
  final DomoticState domoticState;

  LoadUseCase({
    required this.localizationState,
    required this.localizationRepository,
    required this.agencyState,
    required this.agencyRepository,
    required this.domoticState,
    required this.domoticRepository,
  });

  Future<void> _getlanguage() async {
    final locale = await localizationRepository.getLanguage();
    localizationState.locale = locale;
  }

  Future<void> _getMyAgent() async {
    final agencies = await agencyRepository.loadSelectedAgent();
    if (agencies.isRight) {
      agencyState.selectedAgency = agencies.right;
    }
  }

  Future<void> loadDB() async {
    try {
      await GetIt.I.get<DbSetting>().loadDatabase();
      // ignore: empty_catches
    } catch (e) {}
  }

  // Future<void> _loadKnownDevices() async {
  //   final devices = await domoticRepository.getSavedDevices();
  //   if (devices.isRight) {
  //     domoticState.knwonDevices = devices.right;
  //   }
  // }

  Future<void> call() async {
    await loadDB();
    await Future.wait([_getlanguage(), _getMyAgent()]);
  }
}
