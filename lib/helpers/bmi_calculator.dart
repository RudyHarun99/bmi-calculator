import 'package:bmi/constants/constant.dart';

class BmiCalculator {
  int? height;
  int? weight;
  double? bmi;
  String? bmiCategory;
  String? bmiDescription;

  BmiCalculator({required this.height, required this.weight});
  BmiCalculator.fromBmiValue(this.bmi) {
    bmi = bmi;
  }

  double calculateBmi() {
    double heightInMeter = height! / 100;
    bmi = weight! / (heightInMeter * heightInMeter);
    return bmi!;
  }

  String determineBmiCategory() {
    String category = '';

    if (bmi! < 16) {
      category = underweightSevere;
    } else if (bmi! < 17) {
      category = underweightModerate;
    } else if (bmi! < 18.5) {
      category = underweightMild;
    } else if (bmi! < 25) {
      category = normal;
    } else if (bmi! < 30) {
      category = overweight;
    } else if (bmi! < 35) {
      category = obeseI;
    } else if (bmi! < 40) {
      category = obeseII;
    } else if (bmi! >= 40) {
      category = obeseIII;
    }

    bmiCategory = category;
    return category;
  }

  String getHealthRiskDescription() {
    String description = '';

    switch (bmiCategory!) {
      case underweightSevere:
      case underweightModerate:
      case underweightMild:
        description = 'Possible nutritional deficiency and osteoporosis.';
        break;
      case normal:
        description = 'Low Risk (healthy range).';
        break;
      case overweight:
        description =
            'Moderate risk of developing heart disease, high blood pressure, stroke, diabetes mellitus.';
        break;
      case obeseI:
      case obeseII:
      case obeseIII:
        description =
            'High risk of developing heart disease, high blood pressure, stroke, diabetes mellitus.';
        break;
    }

    bmiDescription = description;
    return description;
  }
}
