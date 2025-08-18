import 'package:flutter/material.dart';
import 'package:mileage/components/dropdown.dart';

class UnitInput<T> extends StatelessWidget {
  final String label;

  final T? initialUnit;
  final List<DropdownMenuEntry<T>> units;

  final String? initialValue;

  final void Function(String)? onValueChanged;
  final void Function(T?)? onUnitChanged;

  final BorderRadiusGeometry? borderRadius;

  const UnitInput({
    super.key,
    required this.label,
    required this.units,
    this.initialValue,
    this.initialUnit,
    this.onValueChanged,
    this.onUnitChanged,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[600],
                    ),
                  ),
                  TextFormField(
                    initialValue: initialValue,
                    onChanged: onValueChanged,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60.0,
            child: VerticalDivider(
              thickness: 2.0,
              indent: 5.0,
              endIndent: 5.0,
              radius: const BorderRadius.all(Radius.circular(2.0)),
              color: Colors.grey[300],
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 60.0,
              child: CompactDropdown<T>(
                initialSelection: initialUnit,
                dropdownMenuEntries: units,
                onSelected: onUnitChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
