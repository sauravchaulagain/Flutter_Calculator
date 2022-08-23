import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  Widget calculatebutton(String btntext, Color btncolor, Color textcolor) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        calculation(btntext);
      },
      child: Container(
        height: size.height * 0.095,
        width: size.height * 0.095,
        decoration: BoxDecoration(
            color: btncolor, borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            btntext,
            style: TextStyle(
              fontSize: 35,
              color: textcolor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Center(
          child: Text(
            'Calculator',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.29,
            width: size.width * 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.0171,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35)),
                color: Colors.grey[800]),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      calculatebutton('AC', Colors.black, Colors.red),
                      calculatebutton('/', Colors.black, Colors.greenAccent),
                      calculatebutton('*', Colors.black, Colors.greenAccent),
                      calculatebutton('⌫', Colors.black, Colors.red)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      calculatebutton('7', Colors.black, Colors.white),
                      calculatebutton('8', Colors.black, Colors.white),
                      calculatebutton('9', Colors.black, Colors.white),
                      calculatebutton('+', Colors.black, Colors.greenAccent),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      calculatebutton('4', Colors.black, Colors.white),
                      calculatebutton('5', Colors.black, Colors.white),
                      calculatebutton('6', Colors.black, Colors.white),
                      calculatebutton('-', Colors.black, Colors.greenAccent),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.67,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                calculatebutton(
                                    '1', Colors.black, Colors.white),
                                calculatebutton(
                                    '2', Colors.black, Colors.white),
                                calculatebutton(
                                    '3', Colors.black, Colors.white),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.024,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * 0.44,
                                  child: calculatebutton(
                                      '0', Colors.black, Colors.white),
                                ),
                                calculatebutton(
                                    '.', Colors.black, Colors.white),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.2,
                        height: size.height * 0.205,
                        child: calculatebutton('=', Colors.black, Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String text = '0';

  String expression = '';
  calculation(String btnText) {
    setState(
      () {
        if (btnText == 'AC') {
          text = '0';
        } else if (btnText == '⌫') {
          text = text.substring(0, text.length - 1);
        } else if (btnText == '=') {
          expression = text;
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            text = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            text = 'Error';
          }
        } else {
          if (text == '0') {
            text = btnText;
          } else {
            text = text + btnText;
          }
        }
      },
    );
  }
}
