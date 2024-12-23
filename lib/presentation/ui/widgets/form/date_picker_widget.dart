// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends FormField<DateTime> {
  final String title;
  final DateTime? defaultValue;
  final Function(dynamic value)? onChange;

  DatePickerWidget({
    super.key,
    super.enabled = true,
    super.validator,
    this.onChange,
    required this.title,
    this.defaultValue,
  }) : super(builder: (FormFieldState<DateTime> state) {
          return DatePickerItem(
              title: title,
              errorText: state.errorText,
              defaultValue: defaultValue,
              onChange: (DateTime value) {
                state.didChange(value);
                onChange?.call(value);
              });
        });
}

class DatePickerItem extends StatefulWidget {
  final String? errorText;
  final String title;
  final Function(DateTime value)? onChange;
  final bool enabled;
  final DateTime? defaultValue;

  const DatePickerItem(
      {super.key,
      this.errorText,
      this.defaultValue,
      this.onChange,
      this.enabled = true,
      required this.title});

  @override
  _DatePickerItemState createState() => _DatePickerItemState();
}

class _DatePickerItemState extends State<DatePickerItem> {
  DateTime? selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.value = TextEditingValue(
        text: widget.defaultValue != null
            ? DateFormat('yyyy-MM-dd').format(widget.defaultValue!)
            : "");
  }

  _openDate() async {
    if (!widget.enabled) return;
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime((DateTime.now()).year + 1),
        initialDate: selectedDate ?? widget.defaultValue ?? DateTime.now());
    if (picked != null && (selectedDate != null || picked != selectedDate)) {
      widget.onChange?.call(picked);
      setState(() {
        selectedDate = picked;
      });
    }
    _dateController.value = TextEditingValue(
        text: selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
            : "");
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: _openDate,
      controller: _dateController,
      decoration: InputDecoration(
          hintText: widget.title,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorMaxLines: 2,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          enabledBorder: InputBorder.none,
          suffixIcon: const Icon(Icons.calendar_today_outlined),
          labelText: widget.title),
    );
  }
}
