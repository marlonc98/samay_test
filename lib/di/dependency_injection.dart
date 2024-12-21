import 'package:get_it/get_it.dart';
import 'package:samay/data/repositories/agency/agency_repository_fake.dart';
import 'package:samay/data/repositories/localization/localization_repository_dev.dart';
import 'package:samay/data/repositories/localization/localization_repository_fake.dart';
import 'package:samay/data/repositories/localization/localization_repository_impl.dart';
import 'package:samay/data/repositories/project/project_repository_fake.dart';
import 'package:samay/domain/repositories/agency_respository.dart';
import 'package:samay/domain/repositories/project_repository.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/domain/repositories/localization_repository.dart';
import 'package:samay/domain/use_cases/agency/load_all_agencies_use_case.dart';
import 'package:samay/domain/use_cases/default/load_use_case.dart';
import 'package:samay/domain/use_cases/project/search_projects_use_case.dart';
import 'package:samay/flavors.dart';
import 'package:samay/presentation/states/agency_state_impl.dart';
import 'package:samay/presentation/states/localization_state_impl.dart';

enum ModeDependencyInjection { fake, dev, prod }

class DependencyInjection {
  DependencyInjection() {
    GetIt getIt = GetIt.instance;
    Flavor? mode = F.appFlavor;
    //#region ------------- repositories -------------------------//
    if (mode == Flavor.fake) {
      getIt.registerSingleton<AgencyRepository>(AgencyRepositoryFake());
      getIt.registerSingleton<LocalizationRepository>(
          LocalizationRepositoryFake());
      getIt.registerSingleton<ProjectRepository>(ProjectRepositoryFake());
    } else if (mode == Flavor.dev) {
      getIt.registerSingleton<LocalizationRepository>(
          LocalizationRepositoryDev());
    } else {
      getIt.registerSingleton<LocalizationRepository>(
          LocalizationRepositoryImpl());
    }
    //#endregion repositories

    //#region ------------- providers -------------------------//
    getIt.registerSingleton<AgencyState>(AgencyStateImpl());
    getIt.registerSingleton<LocalizationState>(LocalizationStateImpl());
    //#endregion

    //#region ------------- use cases -------------------------//

    // #region agency
    getIt.registerSingleton<LoadAllAgenciesUseCase>(LoadAllAgenciesUseCase(
        agencyRepository: getIt.get<AgencyRepository>(),
        agencyState: getIt.get<AgencyState>()));
    // #endregion

    //#region default
    getIt.registerSingleton<LoadUseCase>(LoadUseCase(
        agencyRepository: getIt.get<AgencyRepository>(),
        agencyState: getIt.get<AgencyState>(),
        localizationRepository: getIt.get<LocalizationRepository>(),
        localizationState: getIt.get<LocalizationState>()));
    //#endregion
    // //#region project
    getIt.registerSingleton<SearchProjectsUseCase>(SearchProjectsUseCase(
      projectRepository: getIt.get<ProjectRepository>(),
    ));
    //#endregion
    //#endregion
  }
}
