// Import the test package and Counter class
import 'package:mileage/math.dart';
import 'package:test/test.dart';

void main() {
  test('Standard units', () {
    // 0.1 L/km
    final mpg = Mileage(
      volume: Volume(unit: VolumeUnit.litre, value: 0.1),
      distance: Distance(unit: DistanceUnit.kilometre, value: 1.0),
    );

    // 10 km
    final distance = Distance(value: 10.0, unit: DistanceUnit.kilometre);

    // £5/L
    final fuelCost = FuelCost(costPerUnit: 5.0, volumeUnit: VolumeUnit.litre);

    final trip = Trip(distance: distance, mileage: mpg, fuelCost: fuelCost);
    expect(trip.totalCost(), 5.0);
  });

  test('Consistent but non-standard units', () {
    // 10 mpg
    final mpg = Mileage(
      volume: Volume(unit: VolumeUnit.gallon, value: 1),
      distance: Distance(unit: DistanceUnit.mile, value: 10.0),
    );

    // 10 miles
    final distance = Distance(value: 10.0, unit: DistanceUnit.mile);

    // £5 per gallon
    final fuelCost = FuelCost(costPerUnit: 5.0, volumeUnit: VolumeUnit.gallon);

    final trip = Trip(distance: distance, mileage: mpg, fuelCost: fuelCost);
    expect(trip.totalCost(), 5.0);
  });

  test('UK units', () {
    // 10 mpg
    final mpg = Mileage(
      volume: Volume(unit: VolumeUnit.gallon, value: 1),
      distance: Distance(unit: DistanceUnit.mile, value: 10.0),
    );

    // 10 miles
    final distance = Distance(value: 10.0, unit: DistanceUnit.mile);

    // 5p per litre
    final fuelCost = FuelCost(costPerUnit: 0.05, volumeUnit: VolumeUnit.litre);

    final trip = Trip(distance: distance, mileage: mpg, fuelCost: fuelCost);
    expect(trip.totalCost(), closeTo(0.23, 0.005));
  });

  test('Real world', () {
    // 41 mpg
    final mpg = Mileage(
      volume: Volume(unit: VolumeUnit.gallon, value: 1),
      distance: Distance(unit: DistanceUnit.mile, value: 41.0),
    );

    // 2500 mi
    final distance = Distance(value: 2500.0, unit: DistanceUnit.mile);

    // 131p per litre
    final fuelCost = FuelCost(costPerUnit: 1.31, volumeUnit: VolumeUnit.litre);

    final trip = Trip(distance: distance, mileage: mpg, fuelCost: fuelCost);
    expect(trip.totalCost(), closeTo(363.13, 0.005));
  });

  test('Real world using convenience constructors', () {
    // 41 mpg
    final mpg = Mileage.mpg(41.0);

    // 2500 mi
    final distance = Distance.mi(2500.0);

    // 131p per litre
    final fuelCost = FuelCost(costPerUnit: 1.31, volumeUnit: VolumeUnit.litre);

    final trip = Trip(distance: distance, mileage: mpg, fuelCost: fuelCost);
    expect(trip.totalCost(), closeTo(363.13, 0.005));
  });
}
