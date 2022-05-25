import 'package:bmi/constants/constant.dart';
import 'package:bmi/helpers/bmi_calculator.dart';
import 'package:bmi/views/bmi_result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiDataScreen extends StatefulWidget {
  const BmiDataScreen({Key? key}) : super(key: key);

  @override
  State<BmiDataScreen> createState() => _BmiDataScreenState();
}

class _BmiDataScreenState extends State<BmiDataScreen> {
  int height = 100;
  int weight = 50;
  int age = 20;
  String? gender;

  // double calculateBmi() {
  //   double heightInMeter = height / 100;
  //   final bmi = weight / (heightInMeter * heightInMeter);
  //   return bmi;
  // }

  List<Widget> generateList(start, end) {
    List<Widget> weigths = [];
    for (var i = start; i < end; i++) {
      weigths.add(
        Text(
          "$i",
          style: labelTextStyle
        ),
      );
    }
    return weigths;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0E21),
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          final bmiCalculator = BmiCalculator(height: height, weight: weight);
          bmiCalculator.calculateBmi();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) {
                return BmiResultScreen(
                  bmi: bmiCalculator.bmi!,
                );
              }),
            ),
          );
        },
        child: Container(
          height: 50,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: const Color(0xffEC3C66),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              'CALCULATE YOUR BMI',
              style: labelTextStyle!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  gender = 'male';
                  setState(() {});
                },
                child: BmiCard(
                  borderColor: (gender == 'male') ? Colors.white : primaryColor,
                  child: Stack(
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: GenderIconText(
                            icon: Icons.male,
                            title: 'Male',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Icon(
                          Icons.check_circle,
                          color:
                              (gender == "male") ? Colors.white : primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  gender = 'female';
                  setState(() {});
                },
                child: BmiCard(
                  borderColor:
                      (gender == 'female') ? Colors.white : primaryColor,
                  child: Stack(
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: GenderIconText(
                            icon: Icons.female,
                            title: 'Female',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Icon(
                          Icons.check_circle,
                          color: (gender == "female")
                              ? Colors.white
                              : primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ],
          )),
          Column(
            children: [
              Text('HEIGHT', style: labelTextStyle),
              Row(
                children: [
                  Expanded(
                    child: BmiCard(
                      child: Slider(
                        value: height.toDouble(),
                        min: 80,
                        max: 200,
                        thumbColor: Colors.red,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          height = value.toInt();
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  BmiCard(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "$height",
                            style: labelTextStyle,
                          ),
                          Text(
                            "cm",
                            style: labelTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // ))),
          Row(children: [
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('WEIGHT', style: labelTextStyle),
                  // Text('$weight', style: numberStyle),
                  BmiCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: CupertinoPicker(
                            scrollController:
                                FixedExtentScrollController(initialItem: 30),
                            itemExtent: 25,
                            magnification: 2,
                            useMagnifier: true,
                            onSelectedItemChanged: (val) {
                              weight = val + 20;
                              setState(() {});
                            },
                            children: generateList(20, 220),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
          Expanded(
              child: Column(children: [
            Text('AGE', style: labelTextStyle),
            BmiCard(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: CupertinoPicker(
                      scrollController:
                          FixedExtentScrollController(initialItem: 5),
                      itemExtent: 25,
                      magnification: 2,
                      useMagnifier: true,
                      onSelectedItemChanged: (val) {
                        age = val + 15;
                        setState(() {});
                      },
                      children: generateList(15, 220),
                    ),
                  ),
                ],
              ),
            ),
          ])),
        ],
      ),
    );
  }
}

class PlusMinusButton extends StatelessWidget {
  const PlusMinusButton({
    Key? key,
    required this.icon,
    required this.pressed,
  }) : super(key: key);

  final IconData icon;
  final dynamic pressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: pressed,
      elevation: 0,
      shape: const CircleBorder(),
      fillColor: const Color(0xff212747),
      constraints: const BoxConstraints.tightFor(
        width: 56,
        height: 56,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

class BmiCard extends StatelessWidget {
  const BmiCard({
    Key? key,
    this.child,
    this.borderColor = primaryColor,
  }) : super(key: key);

  final Widget? child;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff272A4E),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor!)),
      margin: const EdgeInsets.all(15),
      child: child,
    );
  }
}

class GenderIconText extends StatelessWidget {
  const GenderIconText({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        icon,
        size: 60,
        color: Colors.white,
      ),
      // const SizedBox(height: 15),
      Text(
        title,
        style: labelTextStyle,
      ),
    ]);
  }
}
