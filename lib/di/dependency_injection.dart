import 'package:get_it/get_it.dart';
import 'package:samay/data/repositories/agency/agency_repository_fake.dart';
import 'package:samay/data/repositories/domotic/domotic_repository_dev.dart';
import 'package:samay/data/repositories/domotic/domotic_repository_fake.dart';
import 'package:samay/data/repositories/localization/localization_repository_dev.dart';
import 'package:samay/data/repositories/localization/localization_repository_fake.dart';
import 'package:samay/data/repositories/localization/localization_repository_impl.dart';
import 'package:samay/data/repositories/project/project_repository_fake.dart';
import 'package:samay/domain/repositories/agency_respository.dart';
import 'package:samay/domain/repositories/domotic_repository.dart';
import 'package:samay/domain/repositories/project_repository.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/domain/states/domotic_state.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/domain/repositories/localization_repository.dart';
import 'package:samay/domain/use_cases/agency/load_all_agencies_use_case.dart';
import 'package:samay/domain/use_cases/default/load_use_case.dart';
import 'package:samay/domain/use_cases/domotic/connect_device_use_case.dart';
import 'package:samay/domain/use_cases/domotic/get_connected_devices_use_case.dart';
import 'package:samay/domain/use_cases/domotic/get_saved_devices_use_case.dart';
import 'package:samay/domain/use_cases/domotic/search_devices_to_connect_use_case.dart';
import 'package:samay/domain/use_cases/domotic/toggle_on_device_use_case.dart';
import 'package:samay/domain/use_cases/project/create_project_use_case.dart';
import 'package:samay/domain/use_cases/project/get_project_by_id_use_case.dart';
import 'package:samay/domain/use_cases/project/search_projects_use_case.dart';
import 'package:samay/domain/use_cases/project/update_project_use_case.dart';
import 'package:samay/flavors.dart';
import 'package:samay/presentation/states/agency_state_impl.dart';
import 'package:samay/presentation/states/domotic_state_impl.dart';
import 'package:samay/presentation/states/localization_state_impl.dart';

enum ModeDependencyInjection { fake, dev, prod }

class DependencyInjection {
  DependencyInjection() {
    GetIt getIt = GetIt.instance;
    Flavor? mode = F.appFlavor;
    //#region ------------- repositories -------------------------//
    if (mode == Flavor.fake) {
      getIt.registerSingleton<AgencyRepository>(AgencyRepositoryFake());
      getIt.registerSingleton<DomoticRepository>(DomoticRepositoryFake());
      getIt.registerSingleton<LocalizationRepository>(
          LocalizationRepositoryFake());
      getIt.registerSingleton<ProjectRepository>(ProjectRepositoryFake());
    } else if (mode == Flavor.dev) {
      getIt.registerSingleton<AgencyRepository>(AgencyRepositoryFake());
      getIt.registerSingleton<DomoticRepository>(DomoticRepositoryDev());
      getIt.registerSingleton<LocalizationRepository>(
          LocalizationRepositoryDev());
      getIt.registerSingleton<ProjectRepository>(ProjectRepositoryFake());
    } else {
      getIt.registerSingleton<LocalizationRepository>(
          LocalizationRepositoryImpl());
    }
    //#endregion repositories

    //#region ------------- providers -------------------------//
    getIt.registerSingleton<AgencyState>(AgencyStateImpl());
    getIt.registerSingleton<DomoticState>(DomoticStateImpl());
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
        domoticRepository: getIt.get<DomoticRepository>(),
        domoticState: getIt.get<DomoticState>(),
        localizationRepository: getIt.get<LocalizationRepository>(),
        localizationState: getIt.get<LocalizationState>()));
    //#endregion
    //#region domotic
    getIt.registerSingleton<ConnectDeviceUseCase>(ConnectDeviceUseCase(
      domoticRepository: getIt.get<DomoticRepository>(),
      domoticState: getIt.get<DomoticState>(),
    ));
    getIt.registerSingleton<GetConnectedDevicesUseCase>(
        GetConnectedDevicesUseCase(
      domoticRepository: getIt.get<DomoticRepository>(),
      domoticState: getIt.get<DomoticState>(),
    ));
    getIt.registerSingleton<GetSavedDevicesUseCase>(GetSavedDevicesUseCase(
      domoticRepository: getIt.get<DomoticRepository>(),
    ));
    getIt.registerSingleton<SearchDevicesToConnectUseCase>(
        SearchDevicesToConnectUseCase(
      domoticRepository: getIt.get<DomoticRepository>(),
      domoticState: getIt.get<DomoticState>(),
    ));
    getIt.registerSingleton<ToggleOnDeviceUseCase>(ToggleOnDeviceUseCase(
        domoticRepository: getIt.get<DomoticRepository>(),
        domoticState: getIt.get<DomoticState>()));
    //#endregion
    //#region project
    getIt.registerSingleton<CreateProjectUseCase>(CreateProjectUseCase(
        projectRepository: getIt.get<ProjectRepository>()));
    getIt.registerSingleton<GetProjectByIdUseCase>(GetProjectByIdUseCase(
        projectRepository: getIt.get<ProjectRepository>()));
    getIt.registerSingleton<SearchProjectsUseCase>(SearchProjectsUseCase(
      projectRepository: getIt.get<ProjectRepository>(),
    ));
    getIt.registerSingleton<UpdateProjectUseCase>(UpdateProjectUseCase(
        projectRepository: getIt.get<ProjectRepository>()));
    //#endregion
    //#endregion
  }
}
