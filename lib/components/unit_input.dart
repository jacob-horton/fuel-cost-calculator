import 'package:flutter/material.dart';

class UnitInput<T> extends StatelessWidget {
  final String label;

  final T? initialUnit;
  final List<DropdownMenuEntry<T>> units;

  final String? initialValue;

  final void Function(String)? onValueChanged;
  final void Function(T?)? onUnitChanged;

  const UnitInput({
    super.key,
    required this.label,
    required this.units,
    this.initialValue,
    this.initialUnit,
    this.onValueChanged,
    this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onValueChanged,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: label,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        DropdownMenu(
          initialSelection: initialUnit,
          dropdownMenuEntries: units,
          onSelected: onUnitChanged,
        ),
      ],
    );
  }
}
