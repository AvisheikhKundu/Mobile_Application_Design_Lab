import 'dart:io';

class Course {
  String name;
  Course(this.name);
}

class Student {
  String name;
  int id;
  List<Course> courses = [];
  double _gpa = 0.0;

  Student(this.name, this.id);

  void enrollCourse(Course course) {
    if (!courses.contains(course)) {
      courses.add(course);
      print('$name enrolled in ${course.name}.');
    } else {
      print('$name is already enrolled in ${course.name}.');
    }
  }

  void dropCourse(Course course) {
    if (courses.contains(course)) {
      courses.remove(course);
      print('$name dropped ${course.name}.');
    } else {
      print('$name is not enrolled in ${course.name}.');
    }
  }

  double getGPA() {
    return _gpa;
  }
}

class StudentManagementSystem {
  List<Student> students = [];
  List<Course> availableCourses = [];

  void enrollStudent() {
    stdout.write("Enter student name: ");
    String name = stdin.readLineSync()!;
    
    stdout.write("Enter student ID: ");
    int id = int.parse(stdin.readLineSync()!);
    
    Student student = Student(name, id);
    students.add(student);
    print("Student enrolled successfully!");
  }

  void addCourse() {
    stdout.write("Enter course name: ");
    String courseName = stdin.readLineSync()!;
    
    Course course = Course(courseName);
    availableCourses.add(course);
    print("Course '$courseName' added successfully!");
  }

  void enrollCourse() {
    stdout.write("Enter student ID: ");
    int id = int.parse(stdin.readLineSync()!);
    Student? student = students.firstWhere((s) => s.id == id, orElse: () => Student("", -1));
    
    if (student.id == -1) {
      print("Student not found!");
      return;
    }

    stdout.write("Enter course name: ");
    String courseName = stdin.readLineSync()!;
    Course? course = availableCourses.firstWhere((c) => c.name == courseName, orElse: () => Course(""));
    
    if (course.name.isEmpty) {
      print("Course not found!");
      return;
    }
    
    student.enrollCourse(course);
  }

  void dropCourse() {
    stdout.write("Enter student ID: ");
    int id = int.parse(stdin.readLineSync()!);
    Student? student = students.firstWhere((s) => s.id == id, orElse: () => Student("", -1));
    
    if (student.id == -1) {
      print("Student not found!");
      return;
    }
    
    stdout.write("Enter course name to drop: ");
    String courseName = stdin.readLineSync()!;
    Course? course = availableCourses.firstWhere((c) => c.name == courseName, orElse: () => Course(""));
    
    if (course.name.isEmpty) {
      print("Course not found!");
      return;
    }
    
    student.dropCourse(course);
  }

  void showDashboard() {
    print("\n===== Dashboard =====");
    if (students.isEmpty) {
      print("No students enrolled yet.");
    } else {
      for (var student in students) {
        print("Student: ${student.name} (ID: ${student.id})");
        if (student.courses.isEmpty) {
          print("Enrolled Courses: None\n");
        } else {
          print("Enrolled Courses: ");
          student.courses.forEach((course) {
            print("- ${course.name}");
          });
          print("");
        }
      }
    }
  }
}

void main() {
  StudentManagementSystem sms = StudentManagementSystem();
  
  while (true) {
    print("\n1. Enroll Student");
    print("2. Add Course");
    print("3. Enroll Course");
    print("4. Drop Course");
    print("5. Show Dashboard");
    print("6. Exit");
    stdout.write("Choose an option: ");
    
    int choice = int.parse(stdin.readLineSync()!);
    
    switch (choice) {
      case 1:
        sms.enrollStudent();
        break;
      case 2:
        sms.addCourse();
        break;
      case 3:
        sms.enrollCourse();
        break;
      case 4:
        sms.dropCourse();
        break;
      case 5:
        sms.showDashboard();
        break;
      case 6:
        exit(0);
      default:
        print("Invalid choice. Try again.");
    }
  }
}
