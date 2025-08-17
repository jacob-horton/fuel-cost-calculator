import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mileage/components/input_dialog.dart';
import 'package:mileage/math.dart' as mileage_math;

class MileageCalculator extends StatefulWidget {
  const MileageCalculator({super.key});

  @override
  State<MileageCalculator> createState() => _MileageCalculatorState();
}

class _MileageCalculatorState extends State<MileageCalculator> {
  double? cost;

  @override
  Widget build(BuildContext context) {
    var formatCurrency = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toLanguageTag());

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

            final distance = tripData.distanceUnit == DistanceUnit.mile
                ? mileage_math.Distance.mi(tripData.distance)
                : mileage_math.Distance.km(tripData.distance);

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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 5.0,
                offset: const Offset(0, 2.0),
              ),
            ],
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Total cost:'),
              Text(cost == null ? 'TODO' : formatCurrency.format(cost)),
            ],
          ),
        ),
      ],
    );
  }
}
