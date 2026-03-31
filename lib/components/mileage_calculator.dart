import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fuel_cost_calculator/components/input_dialog.dart';
import 'package:fuel_cost_calculator/math.dart' as mileage_math;

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

    return OrientationBuilder(builder: (context, orientation) {
      return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
        crossAxisSpacing: 50.0,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: InputDialog(
              onCalculate: (tripData) {
                late final mileage_math.Mileage mpg;
                if (tripData.mileageUnit == MileageUnit.mpgImperial) {
                  mpg = mileage_math.Mileage.mpgImperial(tripData.mileage);
                } else if (tripData.mileageUnit == MileageUnit.mpgUs) {
                  mpg = mileage_math.Mileage.mpgUs(tripData.mileage);
                } else {
                  mpg = mileage_math.Mileage.lp100km(tripData.mileage);
                }

                final distance = tripData.distanceUnit == DistanceUnit.mile
                    ? mileage_math.Distance.mi(tripData.distance)
                    : mileage_math.Distance.km(tripData.distance);

                late final mileage_math.VolumeUnit mappedVolumeUnit;
                if (tripData.costVolumeUnit == VolumeUnit.litre) {
                  mappedVolumeUnit = mileage_math.VolumeUnit.litre;
                } else if (tripData.costVolumeUnit == VolumeUnit.usGallon) {
                  mappedVolumeUnit = mileage_math.VolumeUnit.usGallon;
                } else {
                  mappedVolumeUnit = mileage_math.VolumeUnit.imperialGallon;
                }

                final fuelCost = mileage_math.FuelCost(
                    costPerUnit: tripData.costPerUnitVolume,
                    volumeUnit: mappedVolumeUnit);

                final trip = mileage_math.Trip(
                    distance: distance, mileage: mpg, fuelCost: fuelCost);

                setState(() => cost = trip.totalCost());
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
              child: cost == null
                  ? const Text("Press 'Calculate' to see your cost!")
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Your trip will cost:',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Text(
                          formatCurrency.format(cost!),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      );
    });
  }
}
