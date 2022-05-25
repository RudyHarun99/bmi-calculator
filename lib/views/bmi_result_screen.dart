import 'package:bmi/constants/constant.dart';
import 'package:bmi/helpers/bmi_calculator.dart';
import 'package:bmi/views/bmi_data_screen.dart';
import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {
  const BmiResultScreen({Key? key, required this.bmi}) : super(key: key);
  final double bmi;

  // String determineBmiCategory(double bmi) {
  //   String category = '';

  //   if (bmi < 16) {
  //     category = underweightSevere;
  //   } else if (bmi < 17) {
  //     category = underweightModerate;
  //   } else if (bmi < 18.5) {
  //     category = underweightMild;
  //   } else if (bmi < 25) {
  //     category = normal;
  //   } else if (bmi < 30) {
  //     category = overweight;
  //   } else if (bmi < 35) {
  //     category = obeseI;
  //   } else if (bmi < 40) {
  //     category = obeseII;
  //   } else if (bmi >= 40) {
  //     category = obeseIII;
  //   }

  //   return category;
  // }

  // String getHealthRiskDescription(String categoryName) {
  //   String description = '';

  //   switch (categoryName) {
  //     case underweightSevere:
  //     case underweightModerate:
  //     case underweightMild:
  //       description = 'Possible nutritional deficiency and osteoporosis.';
  //       break;
  //     case normal:
  //       description = 'Low Risk (healthy range).';
  //       break;
  //     case overweight:
  //       description =
  //           'Moderate risk of developing heart disease, high blood pressure, stroke, diabetes mellitus.';
  //       break;
  //     case obeseI:
  //     case obeseII:
  //     case obeseIII:
  //       description =
  //           'High risk of developing heart disease, high blood pressure, stroke, diabetes mellitus.';
  //       break;
  //   }

  //   return description;
  // }

  @override
  Widget build(BuildContext context) {
    final BmiCalculator bmiCalculator = BmiCalculator.fromBmiValue(bmi);
    // final bmiCategory = determineBmiCategory(bmi);
    bmiCalculator.determineBmiCategory();
    // final healthDescription = getHealthRiskDescription(bmiCategory);
    bmiCalculator.getHealthRiskDescription();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Caculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Your Result',
                style: labelTextStyle!.copyWith(
                  fontSize: 50,
                  color: primaryColor,
                ),
              ),
            )
          ),
          Expanded(
            flex: 5,
            child: BmiCard(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      bmiCalculator.bmiCategory ?? '',
                      style: labelTextStyle!.copyWith(
                        color: Colors.green,
                      ),
                    ),
                    Text(bmi.toStringAsFixed(1), style: numberStyle),
                    Text(
                      bmiCalculator.bmiDescription ?? '',
                      textAlign: TextAlign.center,
                      style: labelTextStyle,
                    ),
                  ]
                ),
              )
            )
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 80,
              color: const Color(0xffec3e66),
              child: Center(
                child: Text(
                  'RE-CALCULATE',
                  style: labelTextStyle,
                )
              ),
            ),
          ),
        ],
      )
    );
  }
}
