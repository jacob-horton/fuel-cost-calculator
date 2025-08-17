import 'package:flutter/material.dart';
import 'package:mileage/components/unit_input.dart';

enum DistanceUnit { kilometre, mile }

enum VolumeUnit { litre, gallon }

enum MileageUnit { mpg, lp100km }

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
    mileageUnit: MileageUnit.mpg,
    costPerUnitVolume: 1.31,
    costVolumeUnit: VolumeUnit.litre,
  );

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.0,
        children: [
          UnitInput(
            label: 'Distance',
            initialUnit: _trip.distanceUnit,
            initialValue: _trip.distance.toString(),
            onUnitChanged: (unit) {
              if (unit == null) {
                print('No unit selected');
                return;
              }

              setState(() => _trip.distanceUnit = unit);
            },
            onValueChanged: (value) =>
                setState(() => _trip.distance = double.parse(value)),
            units: const [
              DropdownMenuEntry(value: DistanceUnit.mile, label: 'mi'),
              DropdownMenuEntry(value: DistanceUnit.kilometre, label: 'km'),
            ],
          ),
          UnitInput(
            label: 'Mileage',
            initialUnit: _trip.mileageUnit,
            initialValue: _trip.mileage.toString(),
            onUnitChanged: (unit) {
              if (unit == null) {
                print('No unit selected');
                return;
              }

              setState(() => _trip.mileageUnit = unit);
            },
            onValueChanged: (value) =>
                setState(() => _trip.mileage = double.parse(value)),
            units: const [
              DropdownMenuEntry(value: MileageUnit.mpg, label: 'mpg'),
              DropdownMenuEntry(value: MileageUnit.lp100km, label: 'L/100km'),
            ],
          ),
          UnitInput(
            label: 'Cost per unit',
            initialUnit: _trip.costVolumeUnit,
            initialValue: _trip.costPerUnitVolume.toString(),
            onUnitChanged: (unit) {
              if (unit == null) {
                print('No unit selected');
                return;
              }

              setState(() => _trip.costVolumeUnit = unit);
            },
            onValueChanged: (value) =>
                setState(() => _trip.costPerUnitVolume = double.parse(value)),
            units: const [
              DropdownMenuEntry(value: VolumeUnit.litre, label: 'L'),
              DropdownMenuEntry(value: VolumeUnit.gallon, label: 'gallons'),
            ],
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
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
