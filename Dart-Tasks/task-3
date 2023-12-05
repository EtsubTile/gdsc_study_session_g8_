import 'dart:io';
import 'dart:async';

class Calculator {
  double add(double a, double b) {
    return a + b;
  }

  double subtract(double a, double b) {
    return a - b;
  }

  double multiply(double a, double b) {
    return a * b;
  }

  double divide(double a, double b) {
    if (b == 0) {
      throw ZeroDivisionError();
    }
    return a / b;
  }

  ZeroDivisionError() {}
}

void main() {
  Calculator calculator = Calculator();

  try {
    double num1 = double.parse(getUserInput("Enter the first number: "));
    double num2 = double.parse(getUserInput("Enter the second number: "));

    double result = calculator.divide(num1, num2);

    Timer(Duration(seconds: 5), () {
      print("The result is: $result");
    });
  } catch (e) {
    print("Error: $e");
  }
}

String getUserInput(String prompt) {
  print(prompt);
  String input = '';
  while (input.isEmpty) {
    input = stdin.readLineSync()!;
  }
  return input;
}
