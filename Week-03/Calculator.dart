import 'dart:io';

// Abstract class acting as an Interface for Calculator operations
abstract class CalculatorOperations {
  double calculate(double a, double b);
}

// Addition class implementing the interface
class Addition implements CalculatorOperations {
  @override
  double calculate(double a, double b) => a + b;
}

// Subtraction class implementing the interface
class Subtraction implements CalculatorOperations {
  @override
  double calculate(double a, double b) => a - b;
}

// Multiplication class implementing the interface
class Multiplication implements CalculatorOperations {
  @override
  double calculate(double a, double b) => a * b;
}

// Division class implementing the interface
class Division implements CalculatorOperations {
  @override
  double calculate(double a, double b) {
    if (b == 0) {
      print("⚠️ Error: Cannot divide by zero!");
      return double.nan;
    }
    return a / b;
  }
}

// Calculator class to manage user input and operations
class Calculator {
  void start() {
    while (true) {
      print("\n📱 Simple Calculator");
      print("1️⃣ Add");
      print("2️⃣ Subtract");
      print("3️⃣ Multiply");
      print("4️⃣ Divide");
      print("5️⃣ Exit");

      stdout.write("👉 Choose an operation: ");
      String? input = stdin.readLineSync();
      if (input == null || input.isEmpty) {
        print("⚠️ Invalid input. Please enter a number.");
        continue;
      }

      int choice;
      try {
        choice = int.parse(input);
      } catch (e) {
        print("⚠️ Invalid input. Please enter a valid number.");
        continue;
      }

      if (choice == 5) {
        print("🚪 Exiting Calculator. Goodbye!");
        break;
      }

      stdout.write("🔢 Enter first number: ");
      double num1 = double.parse(stdin.readLineSync()!);

      stdout.write("🔢 Enter second number: ");
      double num2 = double.parse(stdin.readLineSync()!);

      CalculatorOperations? operation;

      switch (choice) {
        case 1:
          operation = Addition();
          break;
        case 2:
          operation = Subtraction();
          break;
        case 3:
          operation = Multiplication();
          break;
        case 4:
          operation = Division();
          break;
        default:
          print("⚠️ Invalid choice. Please select a valid option.");
          continue;
      }

      double result = operation.calculate(num1, num2);
      if (!result.isNaN) {
        print("✅ Result: $result");
      }
    }
  }
}

void main() {
  Calculator calculator = Calculator();
  calculator.start();
}
