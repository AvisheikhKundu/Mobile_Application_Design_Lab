class Vehicle {
  String brand;
  String model;

  Vehicle(this.brand, this.model);

  void displayInfo() {
    print('Brand: \$brand, Model: \$model');
  }
}

class ElectricCar extends Vehicle {
  int batteryLevel;

  ElectricCar(String brand, String model, this.batteryLevel) : super(brand, model);

  void displayBatteryLevel() {
    print('Battery Level: \$batteryLevel%');
  }
}

void main() {
  ElectricCar myCar = ElectricCar("Tesla", "Model S", 85);
  myCar.displayInfo();
  myCar.displayBatteryLevel();
}