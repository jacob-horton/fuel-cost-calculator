import 'package:flutter/material.dart';
import 'package:fuel_cost_calculator/components/unit_input.dart';
import 'package:intl/intl.dart';

enum DistanceUnit { kilometre, mile }

enum VolumeUnit { litre, imperialGallon, usGallon }

enum MileageUnit { mpgImperial, mpgUs, lp100km }

class TripData {
  double distance;
  DistanceUnit distanceUnit;

  double mileage;
  MileageUnit mileageUnit;

  double costPerUnitVolume;
  VolumeUnit costVolumeUnit;

  TripData({
    required this.distance,
    required this.distanceUnit,
    required this.mileage,
    required this.mileageUnit,
    required this.costPerUnitVolume,
    required this.costVolumeUnit,
  });
}

class InputDialog extends StatefulWidget {
  final Function(TripData)? onCalculate;

  const InputDialog({super.key, this.onCalculate});

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final TripData _trip = TripData(
    distance: 1.0,
    distanceUnit: DistanceUnit.mile,
    mileage: 41,
    mileageUnit: MileageUnit.mpgImperial,
    costPerUnitVolume: 1.31,
    costVolumeUnit: VolumeUnit.litre,
  );

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat.decimalPattern(
        Localizations.localeOf(context).toLanguageTag());

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 5.0,
            offset: const Offset(0, 2.0),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 5.0,
        children: [
          UnitInput(
            label: 'Distance',
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20.0)),
            initialUnit: _trip.distanceUnit,
            initialValue: numberFormat.format(_trip.distance),
            onUnitChanged: (unit) {
              if (unit == null) {
                print('No unit selected');
                return;
              }

              setState(() => _trip.distanceUnit = unit);
            },
            onValueChanged: (value) => setState(
                () => _trip.distance = numberFormat.parse(value).toDouble()),
            units: const [
              DropdownMenuEntry(value: DistanceUnit.mile, label: 'mi'),
              DropdownMenuEntry(value: DistanceUnit.kilometre, label: 'km'),
            ],
          ),
          UnitInput(
            label: 'Mileage',
            borderRadius: BorderRadius.zero,
            initialUnit: _trip.mileageUnit,
            initialValue: numberFormat.format(_trip.mileage),
            onUnitChanged: (unit) {
              if (unit == null) {
                print('No unit selected');
                return;
              }

              setState(() => _trip.mileageUnit = unit);
            },
            onValueChanged: (value) => setState(
                () => _trip.mileage = numberFormat.parse(value).toDouble()),
            units: const [
              DropdownMenuEntry(
                  value: MileageUnit.mpgImperial, label: 'mpg (Imp)'),
              DropdownMenuEntry(value: MileageUnit.mpgUs, label: 'mpg (US)'),
              DropdownMenuEntry(value: MileageUnit.lp100km, label: 'L/100km'),
            ],
          ),
          UnitInput(
            label: 'Cost per unit',
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(20.0)),
            initialUnit: _trip.costVolumeUnit,
            initialValue: numberFormat.format(_trip.costPerUnitVolume),
            onUnitChanged: (unit) {
              if (unit == null) {
                print('No unit selected');
                return;
              }

              setState(() => _trip.costVolumeUnit = unit);
            },
            onValueChanged: (value) => setState(() =>
                _trip.costPerUnitVolume = numberFormat.parse(value).toDouble()),
            units: const [
              DropdownMenuEntry(value: VolumeUnit.litre, label: 'L'),
              DropdownMenuEntry(
                  value: VolumeUnit.imperialGallon, label: 'gal (Imp)'),
              DropdownMenuEntry(value: VolumeUnit.usGallon, label: 'gal (US)'),
            ],
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (widget.onCalculate != null) {
                widget.onCalculate!(_trip);
              }
            },
            child: Container(
              height: 60.0,
              decoration: const BoxDecoration(
                color: Color(0xFF9A7FE0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: const Center(
                child: Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
