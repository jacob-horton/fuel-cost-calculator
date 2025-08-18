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
                  ? Text("Press 'Calculate' to see your cost!")
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
