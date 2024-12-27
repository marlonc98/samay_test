import 'package:samay/data/db/db_scheme.dart';
import 'package:samay/domain/entities/agency_entity.dart';

class AgencyFromLocalDto {
  static AgencyEntity fromJSON(Map<String, dynamic> json) {
    return AgencyEntity(
      id: json[AgencyTableScheme.id].toString(),
      name: json[AgencyTableScheme.name],
      logo: json[AgencyTableScheme.logo],
      hexColor:
          json[AgencyTableScheme.themeColor].toString().replaceAll("#", ""),
      aditionalFields: [],
    );
  }

  static Map<String, dynamic> toJSON(AgencyEntity agency) {
    return {
      AgencyTableScheme.id: int.parse(agency.id),
      AgencyTableScheme.name: agency.name,
      AgencyTableScheme.logo: agency.logo,
      AgencyTableScheme.themeColor: "#${agency.hexColor}",
    };
  }
}
