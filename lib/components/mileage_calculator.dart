import 'package:flutter/material.dart';
import 'package:mileage/components/input_dialog.dart';
import 'package:mileage/math.dart' as mileage_math;

class MileageCalculator extends StatefulWidget {
  const MileageCalculator({super.key});

  @override
  State<MileageCalculator> createState() => _MileageCalculatorState();
}

class _MileageCalculatorState extends State<MileageCalculator> {
  double cost = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputDialog(
          onCalculate: (tripData) {
            final mpg = tripData.mileageUnit == MileageUnit.mpg
                ? mileage_math.Mileage.mpg(tripData.mileage)
                : mileage_math.Mileage.lp100km(tripData.mileage);

            // 2500 mi
            final distance = tripData.distanceUnit == DistanceUnit.mile
                ? mileage_math.Distance.mi(tripData.distance)
                : mileage_math.Distance.km(tripData.distance);

            // 131p per litre
            final fuelCost = mileage_math.FuelCost(
                costPerUnit: tripData.costPerUnitVolume,
                volumeUnit: tripData.costVolumeUnit == VolumeUnit.litre
                    ? mileage_math.VolumeUnit.litre
                    : mileage_math.VolumeUnit.gallon);

            final trip = mileage_math.Trip(
                distance: distance, mileage: mpg, fuelCost: fuelCost);

            setState(() => cost = trip.totalCost());
          },
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.blue,
          ),
          padding: const EdgeInsets.all(10.0),
          child: Text(cost.toString()),
        ),
      ],
    );
  }
}
