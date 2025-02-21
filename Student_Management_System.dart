import 'dart:io';

class Student {
  String name;
  String id;
  List<String> _courses = [];
  List<String> _droppedCourses = [];
  Map<String, Map<String, double>> _grades = {}; // Stores course percentage & credit hours
  double _gpa = 0.0;

  static const Map<String, double> _availableCourses = {
    "Mobile Application Design": 3.0,
    "Artificial Intelligence": 3.0,
    "Computer Organization and Architecture": 3.0,
    "Compiler Design": 3.0,
    "Machine Learning": 3.0
  };

  Student(this.name, this.id);

  static Map<String, double> getAvailableCourses() => Map.unmodifiable(_availableCourses);

  List<String> get enrolledCourses => List.unmodifiable(_courses);
  List<String> get droppedCourses => List.unmodifiable(_droppedCourses);
  double getGPA() => _gpa;

  void enrollCourse(String course) {
    if (!_courses.contains(course) && _availableCourses.containsKey(course)) {
      _courses.add(course);
      print("✅ Successfully enrolled in: $course");
    } else {
      print("❌ Enrollment failed. Either already enrolled or invalid course.");
    }
  }

  void dropCourse(String course) {
    if (_courses.contains(course)) {
      _courses.remove(course);
      _grades.remove(course);
      _droppedCourses.add(course);
      print("✅ Successfully dropped: $course");
    } else {
      print("❌ Cannot drop. Not enrolled in: $course");
    }
  }

  void updateGPA(Map<String, double> grades) {
    _grades.clear();
    for (var course in grades.keys) {
      _grades[course] = {"percentage": grades[course]!, "credit": _availableCourses[course]!};
    }
    _calculateGPA();
    
    print("\n📊 Individual Course GPA:");
    for (var course in _grades.keys) {
      print("   🔹 $course: ${_grades[course]!['gpa']!.toStringAsFixed(2)}");
    }
    print("🎓 Total CGPA: $_gpa\n");
  }

  void _calculateGPA() {
    if (_grades.isEmpty) {
      _gpa = 0.0;
      return;
    }
    double totalCredits = 0.0;
    double weightedGPA = 0.0;

    for (var course in _grades.keys) {
      double percentage = _grades[course]!['percentage']!;
      double credit = _grades[course]!['credit']!;
      double gradePoint = _getGradePoint(percentage);
      _grades[course]!['gpa'] = gradePoint; // Store each course GPA
      weightedGPA += gradePoint * credit;
      totalCredits += credit;
    }

    _gpa = totalCredits > 0 ? weightedGPA / totalCredits : 0.0;
  }

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

  void viewStudentInfo() {
    print("\n📌 Student Information:");
    print("👤 Name: $name");
    print("🆔 ID: $id");
    print("📚 Enrolled Courses: ${_courses.isEmpty ? "None" : _courses}");
    print("❌ Dropped Courses: ${_droppedCourses.isEmpty ? "None" : _droppedCourses}");
    print("📊 Course-wise GPA:");
    for (var course in _grades.keys) {
      print("   🔹 $course: ${_grades[course]!['gpa']!.toStringAsFixed(2)}");
    }
    print("🎓 Total CGPA: $_gpa\n");
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
    print("1️⃣  View Available Courses");
    print("2️⃣  Enroll in a Course");
    print("3️⃣  Drop a Course");
    print("4️⃣  View Enrolled Courses");
    print("5️⃣  Calculate CGPA");
    print("6️⃣  View Current GPA");
    print("7️⃣  View Student Information");
    print("8️⃣  Exit");
    stdout.write("👉 Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        print("\n📚 Available Courses:");
        Student.getAvailableCourses().forEach((course, credit) {
          print("🔹 $course ($credit credits)");
        });
        break;
      case '2':
        stdout.write("✏ Enter course name to enroll: ");
        String? course = stdin.readLineSync();
        if (course != null) student.enrollCourse(course);
        break;
      case '3':
        stdout.write("✏ Enter course name to drop: ");
        String? course = stdin.readLineSync();
        if (course != null) student.dropCourse(course);
        break;
      case '4':
        print("📚 Enrolled Courses: ${student.enrolledCourses.isEmpty ? "None" : student.enrolledCourses}");
        break;
      case '5':
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
      case '6':
        print("🎓 Current GPA: ${student.getGPA()}");
        break;
      case '7':
        student.viewStudentInfo();
        break;
      case '8':
        print("👋 Exiting... Goodbye!");
        return;
      default:
        print("❌ Invalid option, please try again.");
    }
  }
}
