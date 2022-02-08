import 'package:calculatorapp/aboutPage.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:calculatorapp/listTile.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String userInput = '0';

  List<double> numbers = [];
  List<String> number = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  List<String> operand = ['+', '-', 'x', '/'];

  List<String> sequenceOfOperation = [];

  double result = 0;

  bool decimal = false;

  void onClick(String input) {
    setState(() {
      if (input == 'backspace') {
        print(numbers);
        setState(() {
          if (userInput.isEmpty) {
            userInput = '0';
          } else {
            List<String> userInputList = userInput.split('');

            removeLastValue(userInputList.last);
            userInputList.removeLast();
            userInput = userInputList.join();
          }
        });
      } else if (input == 'C') {
        setState(() {
          /**/
          userInput = '0';

          result = 0;
        });
        numbers = [];
        sequenceOfOperation = [];
        decimal = false;
        /*----- 1 2 3 4 5 6 8 9 0 ------*/
      } else if (number.contains(input) && !decimal) {
        setState(() {
          if (userInput == '0') {
            userInput = input;
            insertCurrentValue(input);
          } else {
            userInput += input;
            insertCurrentValue(input);
          }
        });

        /*-------- + * - / -----------*/
      } else if (operand.contains(input)) {
        decimal = false;
        setState(() {
          userInput += input;

          sequenceOfOperation.add(input);
        });
      } else if (input == '=') {
        if (numbers.length <= sequenceOfOperation.length) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('Syntax error'),
              );
            },
          );
        } else {
          setState(() {
            result = findTheResult();
          });
        }
      } else if (input == '.') {
        userInput += input;

        setState(() {
          decimal = true;
        });
      } else if (number.contains(input) && decimal) {
        print(decimal);
        // Get the last value editable
        double lastVal = numbers.last;

        // Convert to String , split and get the last value
        List<String> editVal = lastVal.toString().split('.');
        String editValDec = editVal.last;
        String editValInt = editVal.first;

        // Add the new input
        if (editValDec == '0') {
          editValDec = input;
        } else {
          editValDec += input;
        }

        // Update the numbers list
        numbers[numbers.length - 1] =
            double.parse(editValInt + '.' + editValDec);

        // Update the UI
        setState(() {
          userInput += input;
        });
        print(numbers);
      }
    });
  }

  // Function which calculate the final result
  double findTheResult() {
    int i = 0;

    // Calculate the multiplication
    while (sequenceOfOperation.indexOf('x') != -1) {
      calculateTwoNumber('x');
    }
    while (sequenceOfOperation.indexOf('/') != -1) {
      calculateTwoNumber('/');
    }
    while (sequenceOfOperation.indexOf('+') != -1) {
      calculateTwoNumber('+');
    }
    while (sequenceOfOperation.indexOf('-') != -1) {
      calculateTwoNumber('-');
    }
    print(numbers);
    return numbers.first;
  }

  void calculateTwoNumber(String op) {
    int indexOfX = sequenceOfOperation.indexOf(op);
    double result;

    if (op == 'x') {
      result = numbers[indexOfX] * numbers[indexOfX + 1];
    } else if (op == '/') {
      result = numbers[indexOfX] / numbers[indexOfX + 1];
    } else if (op == '+') {
      result = numbers[indexOfX] + numbers[indexOfX + 1];
    } else {
      result = numbers[indexOfX] - numbers[indexOfX + 1];
    }

    // Remove the two number from the list

    numbers.removeAt(indexOfX + 1);
    numbers.removeAt(indexOfX);

    // Remove the x operator
    sequenceOfOperation.removeAt(indexOfX);

    numbers.insert(indexOfX, result);
  }

  void insertCurrentValue(String input) {
    if (numbers.length == sequenceOfOperation.length) {
      numbers.add(double.parse(input + '.0'));
    } else if (numbers.length > sequenceOfOperation.length) {
      if (numbers.isEmpty) {
        numbers.add(double.parse(input + '.0'));
      } else {
        // Get the last value editable
        double lastVal = numbers.last;

        // Convert to String , split and get the first value
        String editVal = lastVal.toString().split('.')[0];

        // Add the new input
        editVal += input;

        // Update the numbers list
        numbers[numbers.length - 1] = double.parse(editVal);
      }
    }

    print(numbers);
    print(sequenceOfOperation);
  }

  void removeLastValue(input) {
    if (number.contains(input) && numbers.isNotEmpty) {
      String lastVal = numbers.last.toString();
      String lastValEditable = lastVal.split('.').first;

      // The value is constitued with one number
      if (lastValEditable.length == 1) {
        // Remove the number
        numbers.removeLast();

        // Update the user input
        List<String> inputList = userInput.split('');
        inputList.removeLast();

        // The value has more than one number
      } else {
        List<String> lastValEditList = lastValEditable.split('');
        lastValEditList.removeLast();

        String lastValUpdate = lastValEditList.join();

        numbers.last = double.parse(lastValUpdate + '.');
      }
    } else if (operand.contains(input)) {
      sequenceOfOperation.removeLast();
    }
    print(numbers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.sort),
          ),
        ),
      ),
      drawer: Container(
        color: Colors.white,
        width: 230.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Center(
                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.calculate,
                      color: Colors.blue,
                    ),
                    Text(
                      'Calculator',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              ),
            ),
            listTileWidget(title: 'Basic mode'),
            const Divider(),
            listTileWidget(title: 'Mathematics mode'),
            const Divider(),
            listTileWidget(title: 'Programmers mode'),
            const Divider(),
            listTileWidget(title: 'Physicians mode'),
            const Divider(),
            listTileWidget(title: 'About'),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Text(
                  result.toString(),
                  style: const TextStyle(
                    fontSize: 28.0,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ButtonClass(text: 'backspace', onClick: onClick),
                      ],
                    ),
                    Row(
                      children: [
                        /*Expanded(
                          child: ButtonClass(text: '0', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '0', onClick: onClick),
                        ),*/
                        Expanded(
                          flex: 3,
                          child: ButtonClass(
                            text: 'C',
                            onClick: onClick,
                          ),
                        ),
                        Expanded(
                          child: ButtonClass(text: '/', onClick: onClick),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonClass(text: '1', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '2', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '3', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '+', onClick: onClick),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonClass(text: '4', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '5', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '6', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '-', onClick: onClick),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonClass(text: '7', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '8', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '9', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: 'x', onClick: onClick),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonClass(text: '0', onClick: onClick),
                        ),
                        Expanded(
                          child: ButtonClass(text: '.', onClick: onClick),
                        ),
                        Expanded(
                          flex: 2,
                          child: ButtonClass(text: '=', onClick: onClick),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*----------- Button ----------*/

class ButtonClass extends StatelessWidget {
  ButtonClass({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  final String text;
  ValueChanged<String> onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () {
          onClick(text);
        },
        child: Text(text),
      ),
    );
  }
}
