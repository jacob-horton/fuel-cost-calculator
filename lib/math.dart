// TODO: make some stuff private
enum DistanceUnit { kilometre, mile }

class Distance {
  static final Map<DistanceUnit, double> kmPerUnit = {
    DistanceUnit.kilometre: 1.0,
    DistanceUnit.mile: 1.609344,
  };

  final double value;
  final DistanceUnit unit;

  Distance({required this.value, required this.unit});

  Distance.km(double val)
      : value = val,
        unit = DistanceUnit.kilometre;

  Distance.mi(double val)
      : value = val,
        unit = DistanceUnit.mile;

  double as(DistanceUnit toUnit) {
    return value * kmPerUnit[unit]! / kmPerUnit[toUnit]!;
  }
}

enum VolumeUnit { litre, gallon }

class Volume {
  static final Map<VolumeUnit, double> litresPerUnit = {
    VolumeUnit.litre: 1.0,
    VolumeUnit.gallon: 4.54609,
  };

  final double value;
  final VolumeUnit unit;

  Volume({required this.value, required this.unit});

  Volume.litre(double val)
      : value = val,
        unit = VolumeUnit.litre;

  Volume.gallon(double val)
      : value = val,
        unit = VolumeUnit.gallon;

  double as(VolumeUnit toUnit) {
    return value * litresPerUnit[unit]! / litresPerUnit[toUnit]!;
  }
}

class Mileage {
  final Distance distance;
  final Volume volume;

  Mileage({required this.distance, required this.volume});

  Mileage.mpg(double value)
      : distance = Distance(value: value, unit: DistanceUnit.mile),
        volume = Volume(value: 1.0, unit: VolumeUnit.gallon);

  Mileage.lp100km(double value)
      : distance = Distance(value: 100, unit: DistanceUnit.kilometre),
        volume = Volume(value: value, unit: VolumeUnit.litre);

  double asVolPerDist(VolumeUnit volumeUnit, DistanceUnit distanceUnit) {
    return volume.as(volumeUnit) / distance.as(distanceUnit);
  }
}

class FuelCost {
  final double costPerUnit;
  final VolumeUnit volumeUnit;

  FuelCost({required this.costPerUnit, required this.volumeUnit});

  double pricePer(VolumeUnit unit) {
    return costPerUnit *
        (Volume.litresPerUnit[unit]! / Volume.litresPerUnit[volumeUnit]!);
  }
}

class Trip {
  final Distance distance;
  final Mileage mileage;
  final FuelCost fuelCost;

  Trip({required this.distance, required this.mileage, required this.fuelCost});

  double totalCost() {
    final litresOfFuel =
        mileage.asVolPerDist(VolumeUnit.litre, DistanceUnit.kilometre) *
            distance.as(DistanceUnit.kilometre);
    final cost = fuelCost.pricePer(VolumeUnit.litre) * litresOfFuel;

    return cost;
  }
}
