import 'package:samay/domain/repositories/agency_respository.dart';
import 'package:samay/domain/repositories/localization_repository.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/domain/states/localization_state.dart';

class LoadUseCase {
  final LocalizationRepository localizationRepository;
  final LocalizationState localizationState;
  final AgencyRepository agencyRepository;
  final AgencyState agencyState;

  LoadUseCase({
    required this.localizationState,
    required this.localizationRepository,
    required this.agencyState,
    required this.agencyRepository,
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

  Future<void> call() async {
    await Future.wait([_getlanguage(), _getMyAgent()]);
  }
}
