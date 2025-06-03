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
    mileage: 40,
    mileageUnit: MileageUnit.mpg,
    costPerUnitVolume: 1.30,
    costVolumeUnit: VolumeUnit.litre,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.blue,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(height: 20.0),
          TextButton(
            onPressed: () {
              if (widget.onCalculate != null) {
                widget.onCalculate!(_trip);
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text('Calculate'),
          ),
        ],
      ),
    );
  }
}
