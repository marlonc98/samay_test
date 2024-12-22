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
        underline: const SizedBox(),
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
              : [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 16),
                    child: Text(
                      'Select real state agency',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                ],
        ),
        icon: const Icon(Icons.keyboard_arrow_down), // Dropdown icon
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
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
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