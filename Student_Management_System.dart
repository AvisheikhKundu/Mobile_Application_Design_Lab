import 'dart:io';

class Student {
  String name;
  String id;
  List<String> _courses = [];
  double _gpa = 0.0;

  // Private available courses
  static const List<String> _availableCourses = [
    "Mobile Application Design",
    "Artificial Intelligence",
    "Computer Organization and Architecture",
    "Compiler Design",
    "Machine Learning"
  ];

  Student(this.name, this.id);

  // Getter for available courses (Encapsulation applied)
  static List<String> getAvailableCourses() => List.unmodifiable(_availableCourses);

  // Getter for enrolled courses
  List<String> get enrolledCourses => List.unmodifiable(_courses);

  // Getter for GPA
  double getGPA() => _gpa;

  // Enroll in a course
  void enrollCourse(String course) {
    if (!_courses.contains(course) && _availableCourses.contains(course)) {
      _courses.add(course);
      print("✅ Successfully enrolled in: $course");
    } else {
      print("❌ Enrollment failed. Either already enrolled or invalid course.");
    }
  }

  // Drop a course
  void dropCourse(String course) {
    if (_courses.contains(course)) {
      _courses.remove(course);
      print("✅ Successfully dropped: $course");
    } else {
      print("❌ Cannot drop. Not enrolled in: $course");
    }
  }

  // Update GPA after entering grades
  void updateGPA(Map<String, double> grades) {
    _gpa = _calculateGPA(grades);
    print("📊 Updated GPA: $_gpa");
  }

  // Private method for GPA calculation (Encapsulation)
  double _calculateGPA(Map<String, double> grades) {
    if (grades.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var grade in grades.values) {
      total += _getGradePoint(grade);
    }
    return total / grades.length;
  }

  // Private method for grade point conversion
  double _getGradePoint(double percentage) {
    if (percentage >= 80) return 4.00;
    if (percentage >= 75) return 3.75;
    if (percentage >= 70) return 3.50;
    if (percentage >= 65) return 3.25;
    if (percentage >= 60) return 3.00;
    if (percentage >= 55) return 2.75;
    if (percentage >= 50) return 2.50;
    if (percentage >= 45) return 2.25;
    if (percentage >= 40) return 2.00;
    return 0.00;
  }
}

void main() {
  stdout.write("👤 Enter student name: ");
  String? name = stdin.readLineSync();
  stdout.write("🆔 Enter student ID: ");
  String? id = stdin.readLineSync();

  if (name == null || id == null || name.isEmpty || id.isEmpty) {
    print("❌ Invalid input. Exiting...");
    return;
  }

  Student student = Student(name, id);

  while (true) {
    print("\n📌 Dashboard");
    print("1️⃣  Student Name: ${student.name}");
    print("2️⃣  Student ID: ${student.id}");
    print("3️⃣  Available Courses: ${Student.getAvailableCourses()}");
    print("4️⃣  Enroll in a Course");
    print("5️⃣  Drop a Course");
    print("6️⃣  View Enrolled Courses");
    print("7️⃣  Calculate CGPA");
    print("8️⃣  View Current GPA");
    print("9️⃣  Exit");
    stdout.write("👉 Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '4':
        stdout.write("✏ Enter course name to enroll: ");
        String? course = stdin.readLineSync();
        if (course != null) student.enrollCourse(course);
        break;
      case '5':
        stdout.write("✏ Enter course name to drop: ");
        String? course = stdin.readLineSync();
        if (course != null) student.dropCourse(course);
        break;
      case '6':
        print("📚 Enrolled Courses: ${student.enrolledCourses.isEmpty ? "None" : student.enrolledCourses}");
        break;
      case '7':
        if (student.enrolledCourses.isEmpty) {
          print("⚠ No courses enrolled. GPA calculation not possible.");
          break;
        }
        Map<String, double> grades = {};
        for (var course in student.enrolledCourses) {
          stdout.write("📊 Enter percentage for $course: ");
          String? gradeInput = stdin.readLineSync();
          double? percentage = double.tryParse(gradeInput ?? "");
          if (percentage != null) {
            grades[course] = percentage;
          }
        }
        student.updateGPA(grades);
        break;
      case '8':
        print("🎓 Current GPA: ${student.getGPA()}");
        break;
      case '9':
        print("👋 Exiting... Goodbye!");
        return;
      default:
        print("❌ Invalid option, please try again.");
    }
  }
}
