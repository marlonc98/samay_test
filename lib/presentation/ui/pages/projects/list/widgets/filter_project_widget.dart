import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/entities/project_filter_entity.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/presentation/ui/widgets/form/validators.dart';
import 'package:samay/utils/currency_format.dart';
import 'package:samay/utils/key_words_constants.dart';

class FilterProjectWidget extends StatefulWidget {
  final Function(ProjectFilterEntity filter) onFilter;
  final ProjectFilterEntity filter;

  const FilterProjectWidget({
    super.key,
    required this.filter,
    required this.onFilter,
  });

  @override
  State<StatefulWidget> createState() => _FilterProjectWidget();
}

class _FilterProjectWidget extends State<FilterProjectWidget> {
  int? minPrice;
  int? maxPrice;
  String? location;

  TextEditingController controllerFrom = TextEditingController();
  TextEditingController controllerTo = TextEditingController();

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() {
    minPrice = widget.filter.minPrice;
    maxPrice = widget.filter.maxPrice;
    location = widget.filter.location;
    controllerFrom.text =
        CurrencyFormat.formatCurrencyString(minPrice.toString()) ?? '';
    controllerTo.text =
        CurrencyFormat.formatCurrencyString(maxPrice.toString()) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<LocalizationState>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: MediaQuery.of(context).size.height * 0.5,
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(context).size.height * 0.5,
      // ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Text(
            localization.translate(KeyWordsConstants.filterProjectWidgetTitle),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: localization.translate(
                KeyWordsConstants.filterProjectWidgetLocation,
              ),
              prefixIcon: const Icon(
                Icons.map_outlined,
              ),
            ),
            onChanged: (value) => location = value,
            initialValue: widget.filter.location,
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              localization.translate(
                KeyWordsConstants.filterProjectWidgetPrice,
              ),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Row(children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: localization.translate(
                    KeyWordsConstants.filterProjectWidgetMin,
                  ),
                  prefixIcon: const Icon(
                    Icons.attach_money,
                  ),
                ),
                controller: controllerFrom,
                onChanged: (String? val) {
                  CurrencyFormat.loadControllerCurrency(
                      controllerFrom, minPrice);
                  minPrice = CurrencyFormat.usdToInt(controllerFrom.text);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                validator: (val) => Validators.check(
                  text: val,
                  context: context,
                  type: FormType.currency,
                  maxValue: maxPrice ?? 9999999999,
                  minValue: 0,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: localization.translate(
                    KeyWordsConstants.filterProjectWidgetMax,
                  ),
                  prefixIcon: const Icon(
                    Icons.attach_money,
                  ),
                ),
                controller: controllerTo,
                onChanged: (String? val) {
                  CurrencyFormat.loadControllerCurrency(controllerTo, maxPrice);
                  maxPrice = CurrencyFormat.usdToInt(controllerTo.text);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                validator: (val) => Validators.check(
                  text: val,
                  context: context,
                  type: FormType.currency,
                  maxValue: 9999999999,
                  minValue: minPrice ?? 0,
                ),
              ),
            ),
          ]),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onFilter(
                      ProjectFilterEntity(
                        location: location,
                        minPrice: minPrice,
                        maxPrice: maxPrice,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(localization.translate(
                    KeyWordsConstants.filterProjectWidgetFilter,
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
