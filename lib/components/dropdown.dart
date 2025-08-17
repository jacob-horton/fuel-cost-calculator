import 'package:flutter/material.dart';

class CompactDropdown<T> extends StatefulWidget {
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final T? initialSelection;
  final void Function(T?)? onSelected;

  const CompactDropdown({
    super.key,
    required this.dropdownMenuEntries,
    required this.initialSelection,
    this.onSelected,
  });

  @override
  State<CompactDropdown> createState() => _CompactDropdownState<T>();
}

class _CompactDropdownState<T> extends State<CompactDropdown<T>> {
  late T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: PopupMenuButton<T>(
        padding: EdgeInsets.zero,
        onSelected: (value) {
          setState(() {
            selectedValue = value;
          });

          if (widget.onSelected != null) widget.onSelected!(value);
        },
        itemBuilder: (context) => widget.dropdownMenuEntries
            .map((e) => PopupMenuItem<T>(
                  value: e.value,
                  height: 30,
                  child: Text(e.label),
                ))
            .toList(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 60,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.dropdownMenuEntries
                  .firstWhere((x) => x.value == selectedValue)
                  .label),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
