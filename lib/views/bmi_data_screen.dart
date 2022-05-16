import 'package:bmi/constants/constant.dart';
import 'package:bmi/views/bmi_result_screen.dart';
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

  double calculateBmi() {
    double heightInMeter = height / 100;
    final bmi = weight / (heightInMeter * heightInMeter);
    return bmi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0E21),
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    gender = 'male';
                    setState(() {});
                  },
                  child: BmiCard(
                    borderColor: (gender == 'male') ? Colors.white : primaryColor,
                    child: const GenderIconText(
                      icon: Icons.male,
                      title: 'Male',
                    ),
                  ),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    gender = 'female';
                    setState(() {});
                  },
                  child: BmiCard(
                    borderColor: (gender == 'female') ? Colors.white : primaryColor,
                    child: const GenderIconText(
                      icon: Icons.female,
                      title: 'Female',
                    ),
                  ),
                )
              ),
            ],
          )),
          Expanded(
              child: BmiCard(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HEIGHT',
                style: labelTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('$height', style: numberStyle),
                    Text(
                      'cm',
                      style: labelTextStyle,
                    )
                  ]),
              Slider(
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
            ],
          ))),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: BmiCard(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('WEIGHT', style: labelTextStyle),
                      Text('$weight', style: numberStyle),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PlusMinusButton(
                                icon: Icons.add,
                                pressed: () {
                                  weight++;
                                  setState(() {});
                                }),
                            const SizedBox(width: 10),
                            PlusMinusButton(
                                icon: Icons.remove,
                                pressed: () {
                                  weight--;
                                  setState(() {});
                                }),
                          ]),
                    ]),
              )),
              Expanded(
                  child: BmiCard(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('AGE', style: labelTextStyle),
                      Text('$age', style: numberStyle),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PlusMinusButton(
                                icon: Icons.add,
                                pressed: () {
                                  age++;
                                  setState(() {});
                                }),
                            const SizedBox(width: 10),
                            PlusMinusButton(
                                icon: Icons.remove,
                                pressed: () {
                                  age--;
                                  setState(() {});
                                }),
                          ]),
                    ]),
              )),
            ],
          )),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) {
                  return BmiResultScreen(bmi: calculateBmi());
                })),
              );
            },
            child: Container(
              height: 60,
              color: const Color(0xffec3e66),
              child: Center(
                  child: Text('CALCULATE YOUR BMI', style: labelTextStyle)),
            ),
          ),
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
        size: 80,
        color: Colors.white,
      ),
      const SizedBox(height: 15),
      Text(
        title,
        style: labelTextStyle,
      ),
    ]);
  }
}
