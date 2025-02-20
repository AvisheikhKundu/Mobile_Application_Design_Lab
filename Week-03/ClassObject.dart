class Dog {
  String name;
  int age;
  
  Dog(this.name, this.age); // Constructor
  
  void bark() {
    print('uff!');
  }
}
void main() {
  Dog myDog = Dog('Buddy', 3);
  myDog.bark();
}