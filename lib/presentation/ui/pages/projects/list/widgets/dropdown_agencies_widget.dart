import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/agency_entity.dart';
import 'package:samay/domain/states/agency_state.dart';
import 'package:samay/domain/use_cases/agency/load_all_agencies_use_case.dart';

class DropdownAgenciesWidget extends StatefulWidget {
  final Function(AgencyEntity? agency)? onChange;

  const DropdownAgenciesWidget({super.key, this.onChange});

  @override
  State<DropdownAgenciesWidget> createState() => _DropdownAgenciesWidgetState();
}

class _DropdownAgenciesWidgetState extends State<DropdownAgenciesWidget> {
  @override
  void initState() {
    _loadAgencies();
    super.initState();
  }

  void _loadAgencies() {
    print("called _loadAgencies in constructor");
    GetIt.I.get<LoadAllAgenciesUseCase>().call();
  }

  @override
  Widget build(BuildContext context) {
    final agencyState = Provider.of<AgencyState>(context);
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<String>(
        value: agencyState.selectedAgency?.id,
        hint: Row(
          children: agencyState.selectedAgency != null
              ? [
                  Image.network(
                    agencyState.selectedAgency!.logo,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(agencyState.selectedAgency!.name +
                      agencyState.listOfAgencies.length.toString()),
                ]
              : const [
                  Text('Select an option'),
                ],
        ),
        icon: const Icon(Icons.arrow_drop_down,
            color: Colors.blue), // Dropdown icon
        items: agencyState.listOfAgencies.map((AgencyEntity item) {
          return DropdownMenuItem<String>(
            value: item.id,
            child: Row(
              children: [
                Image.network(
                  item.logo,
                  height: 20,
                ),
                const SizedBox(width: 8),
                Text(item.name),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          agencyState.selectedAgency = agencyState.listOfAgencies
              .firstWhere((element) => element.id == value);
        },
      ),
    );
  }
}
