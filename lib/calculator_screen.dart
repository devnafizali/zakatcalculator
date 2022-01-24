import 'package:HerregaZakaa/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController moneyValue = TextEditingController();
  double money = 0;

  TextEditingController goldValue = TextEditingController();

  TextEditingController goldWeight = TextEditingController();

  double goldPrice = 0;

  TextEditingController silverValue = TextEditingController();

  TextEditingController silverWeight = TextEditingController();

  double silverPrice = 0;

  double totalZakat = 0;

  @override
  void dispose() {
    moneyValue.dispose();
    goldValue.dispose();
    goldWeight.dispose();
    silverValue.dispose();
    silverWeight.dispose();
    super.dispose();
  }

  void calculateZakat() {
    setState(() {
      goldPrice = double.parse(goldValue.text) * double.parse(goldWeight.text);
      silverPrice =
          double.parse(silverValue.text) * double.parse(silverWeight.text);
      money = double.parse(moneyValue.text);

      totalZakat = (goldPrice + silverPrice + money) / 40;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            IconText('Money', Icon(Icons.attach_money)),
            MoneyWidget(moneyValue),
            IconText('Gold', Icon(Icons.panorama_photosphere_select_outlined)),
            ValueWidget(
              Value: goldValue,
              Weight: goldWeight,
              Price: goldPrice,
            ),
            IconText('Silver', Icon(Icons.ac_unit)),
            ValueWidget(
              Value: silverValue,
              Weight: silverWeight,
              Price: silverPrice,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.orangeAccent[400]),
              ),
              onPressed: () {
                calculateZakat();
              },
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Text('Total Zakat'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 60,
              // padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 340,
                    child: Center(
                      child: Text(
                        '$totalZakat',
                        style: TextStyle(
                            color: Colors.orangeAccent[400],
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.attach_money),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MoneyWidget extends StatelessWidget {
  TextEditingController moneyValue;
  MoneyWidget(
    this.moneyValue, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 290,
              child: TextFormField(
                controller: moneyValue,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Icon(Icons.attach_money)
          ],
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  String text;
  Icon icon;
  IconText(
    this.text,
    this.icon, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 17, color: Colors.grey, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class ValueWidget extends StatelessWidget {
  VoidCallback? valueFun, weightfun;
  ValueWidget({
    Key? key,
    required this.Value,
    required this.Weight,
    required this.Price,
    this.valueFun,
    this.weightfun,
  }) : super(key: key);

  final TextEditingController Value;
  final TextEditingController Weight;
  final double Price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: MyFields(
                  'Value(\$)',
                  Value,
                  w: 120,
                  fn: valueFun,
                ),
              ),
              SizedBox(
                width: 100,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: MyFields('Weight (g)', Weight, w: 120, fn: weightfun),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Total (\$)',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Container(
            width: 340,
            height: 50,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                '$Price',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyFields extends StatelessWidget {
  TextEditingController editingController;
  VoidCallback? fn;
  String label;
  double w = 120;
  MyFields(
    this.label,
    this.editingController, {
    this.fn,
    required this.w,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Container(
          width: w,
          height: 50,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextFormField(
              // initialValue: '0',
              onChanged: (value) {
                fn;
              },
              maxLines: 1,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              controller: editingController,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
