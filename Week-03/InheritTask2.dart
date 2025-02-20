// Parent class: Vehicle
class Vehicle {
  int numberOfWheels;
  double price;
  String brand;

  // Constructor for Vehicle class
  Vehicle(this.numberOfWheels, this.price, this.brand);

  // Method to display vehicle details
  void displayDetails() {
    print('Brand: $brand');
    print('Price: \$${price}');
    print('Number of Wheels: $numberOfWheels');
  }
}

// Child class: ElectricCar inherits from Vehicle
class ElectricCar extends Vehicle {
  double batteryLevel; // Property specific to ElectricCar

  // Constructor for ElectricCar class, calling the parent class constructor
  ElectricCar(int numberOfWheels, double price, String brand, this.batteryLevel)
      : super(numberOfWheels, price, brand);

  // Overriding method to display details including battery level
  @override
  void displayDetails() {
    super.displayDetails(); // Call to parent class method
    print('Battery Level: ${batteryLevel}%');
  }
}

void main() {
  // Create an instance of Vehicle
  Vehicle myVehicle = Vehicle(4, 25000, 'Toyota');
  myVehicle.displayDetails();
  
  print('');

  // Create an instance of ElectricCar
  ElectricCar myElectricCar = ElectricCar(4, 35000, 'Tesla', 85);
  myElectricCar.displayDetails();
}
