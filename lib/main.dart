import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Transcript System',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StudentInfoForm(),
    );
  }
}


// STUDENT INFORMATION OR THE HOME SCREEN
class StudentInfoForm extends StatefulWidget {
  const StudentInfoForm({super.key});

  @override
  StudentInfoFormState createState() => StudentInfoFormState();
}

class StudentInfoFormState extends State<StudentInfoForm> {
  final globalFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final collegeController = TextEditingController();
  final examRollController = TextEditingController();
  final registrationController = TextEditingController();
  final sessionController = TextEditingController();
  int selectedYears = 1;
  final semestersController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    collegeController.dispose();
    examRollController.dispose();
    registrationController.dispose();
    sessionController.dispose();
    semestersController.dispose();
    super.dispose();
  }

  final Color borderColor = const Color(0xFF003366);
  final Color fillColor = const Color(0xFF99CC33);

  final Color labelTextColor = const Color(0xff3a792e);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff3a792e),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Image.asset(
                'assets/images/UFV-50.png', // Replace with your image path
                height: 40, // Adjust the height of the logo as needed
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: globalFormKey,
              child: ListView(
                children: [
                  const Center(
                    child: Text(
                      "Student Information",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  StudenttextInformationTextField(
                    controller: nameController,
                    label: 'Student Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter student name';
                      } else if (RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Numbers are not allowed';
                      }
                      return null;
                    },
                  ),
                  StudenttextInformationTextField(
                    controller: fatherNameController,
                    label: 'Father\'s Name',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter father\'s name'
                        : null,
                  ),
                  StudenttextInformationTextField(
                    controller: motherNameController,
                    label: 'Mother\'s Name',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter mother\'s name'
                        : null,
                  ),
                  StudenttextInformationTextField(
                    controller: collegeController,
                    label: 'College Name',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter college name'
                        : null,
                  ),
                  StudentInformationTextField(
                    controller: examRollController,
                    label: 'Exam Roll',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter exam roll'
                        : null,
                  ),
                  StudentInformationTextField(
                    controller: registrationController,
                    label: 'Registration No.',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter registration number'
                        : null,
                  ),
                  StudentInformationTextField(
                    controller: semestersController,
                    label: 'Number of Semesters',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter number of semesters';
                      }
                      final semesters = int.tryParse(value!);
                      if (semesters == null || semesters < 1) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3a792e),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 4.0, // Button shadow
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget StudenttextInformationTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.black87),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: labelTextColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: labelTextColor, width: 4.0),
            ),
            filled: true,
            fillColor: fillColor,
          ),
          validator: validator,
          style: TextStyle(color: borderColor),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
          ],
        ));
  }

  Widget StudentInformationTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(),
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.black87),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: labelTextColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: labelTextColor, width: 4.0),
            ),
            filled: true,
            fillColor: fillColor,
          ),
          validator: validator,
          style: TextStyle(color: borderColor),
        ));
  }

  void submitForm() {
    if (globalFormKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CourseInputScreen(
            studentName: nameController.text,
            fatherName: fatherNameController.text,
            motherName: motherNameController.text,
            collegeName: collegeController.text,
            examRoll: examRollController.text,
            registrationNo: registrationController.text,
            totalSemesters: int.parse(semestersController.text),
          ),
        ),
      );
    }
  }
}


// COURSE ENTRY SCREEN
class CourseInputScreen extends StatefulWidget {
  final String studentName;
  final String fatherName;
  final String motherName;
  final String collegeName;
  final String examRoll;
  final String registrationNo;
  final int totalSemesters;

  const CourseInputScreen({
    super.key,
    required this.studentName,
    required this.fatherName,
    required this.motherName,
    required this.collegeName,
    required this.examRoll,
    required this.registrationNo,
    required this.totalSemesters,
  });

  @override
  CourseInputScreenState createState() => CourseInputScreenState();
}

class CourseInputScreenState extends State<CourseInputScreen> {
  final List<Semester> allSemesters = [];
  int currentSemester = 1;
  final List<Course> currentCourses = [];
  final globalFormKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  final creditsController = TextEditingController();
  final scoreController = TextEditingController();
  String selectedGrade = 'A';
  final List<String> grades = [
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'C-',
    'D+',
    'D',
    'F'
  ];

  @override
  void dispose() {
    codeController.dispose();
    creditsController.dispose();
    scoreController.dispose();
    super.dispose();
  }

  final Color borderColor = const Color(0xFF003366);
  final Color fillColor = const Color(0xFF99CC33);
  final Color labelTextColor = const Color(0xff3a792e);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff3a792e),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Image.asset(
                'assets/images/UFV-50.png',
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: globalFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      color: Colors.white,
                      shadowColor: Colors.green.withOpacity(0.9),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text("Enter the course information",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                )),
                            TextFormField(
                              controller: codeController,
                              decoration: InputDecoration(
                                labelText: "Enter Course Code",
                                labelStyle:
                                    const TextStyle(color: Colors.black87),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: labelTextColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: labelTextColor, width: 4.0),
                                ),
                                filled: true,
                                fillColor: fillColor,
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter course code';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: creditsController,
                              decoration: InputDecoration(
                                labelText: "Enter Course Credit (3 or 4)",
                                labelStyle:
                                    const TextStyle(color: Colors.black87),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: labelTextColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: labelTextColor, width: 4.0),
                                ),
                                filled: true,
                                fillColor: fillColor,
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter credits';
                                }
                                final credits = int.tryParse(value!);
                                if (credits == null) {
                                  return 'Please enter a valid number';
                                }
                                if (credits != 3 && credits != 4) {
                                  return 'Credits must be either 3 or 4';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: scoreController,
                              decoration: InputDecoration(
                                labelText: "Enter Course Score (0-100)",
                                labelStyle:
                                    const TextStyle(color: Colors.black87),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: labelTextColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: labelTextColor, width: 4.0),
                                ),
                                filled: true,
                                fillColor: fillColor,
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter a score';
                                }
                                final score = int.tryParse(value!);
                                if (score == null || score < 0 || score > 100) {
                                  return 'Score must be between 0 and 100';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                              onPressed: addCourseList,
                              icon: const Icon(Icons.add),
                              label: const Text('Add Course'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff3a792e),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 4.0,
                              )),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: currentCourses.isNotEmpty
                                ? finishSemesterbtn
                                : null,
                            icon: const Icon(Icons.check),
                            label: const Text('Finish Semester'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff3a792e),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 4.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Current Semester Courses:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: ListView.separated(
                          itemCount: currentCourses.length,
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xFF003366),
                            thickness: 1.0,
                          ),
                          itemBuilder: (context, index) {
                            final course = currentCourses[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDFF2E1),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 6.0,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: labelTextColor,
                                  child: Text(
                                    '${course.credits}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  course.code,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
  'Score: ${course.NumberScore}%, Grade: ${course.letterGrade}, CGP: ${course.qualityPoint.toStringAsFixed(2)}',
  style: TextStyle(color: labelTextColor),
),

                                
                                
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => removeCourseList(index),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void removeCourseList(int index) {
    setState(() {
      currentCourses.removeAt(index);
    });
  }

 void addCourseList() {
  if (globalFormKey.currentState?.validate() ?? false) {
    setState(() {
      String calculatedGrade = calculateGrade(int.parse(scoreController.text));
      double gradePointValue = calculateGPV(calculatedGrade);
      int credits = int.parse(creditsController.text);
      double qualityPoints = credits * gradePointValue;


      currentCourses.add(
        Course(
          code: codeController.text,
          credits: credits,
          letterGrade: calculatedGrade,
          NumberScore: int.parse(scoreController.text),
          qualityPoint: qualityPoints,
        ),
      );
    });


    codeController.clear();
    creditsController.clear();
    scoreController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

double calculateGPV(String letterGrade) {
  const gradePoints = {
    'A+': 4.33,
    'A': 4.00,
    'A-': 3.67,
    'B+': 3.33,
    'B': 3.00,
    'B-': 2.67,
    'C+': 2.33,
    'C': 2.00,
    'C-': 1.67,
    'D': 1.00,
    'F': 0.00,
  };
  return gradePoints[letterGrade] ?? 0.0;
}


  String calculateGrade(int score) {
    if (score >= 90) return 'A+';
    if (score >= 85) return 'A';
    if (score >= 80) return 'A-';
    if (score >= 77) return 'B+';
    if (score >= 73) return 'B';
    if (score >= 70) return 'B-';
    if (score >= 67) return 'C+';
    if (score >= 63) return 'C';
    if (score >= 60) return 'C-';
    if (score >= 50) return 'D';
    return 'F';
  }

  void finishSemesterbtn() {
    final semester = Semester(
      number: currentSemester,
      courses: List.from(currentCourses),
    );

    if (!semester.validateCredits()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Credits'),
          content: const Text(
              'Total credits for the semester must be between 9 and 22 credits.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    allSemesters.add(semester);

    if (currentSemester < widget.totalSemesters) {
      setState(() {
        currentSemester++;
        currentCourses.clear();
      });
    } else {
      {
        final student = Student(
          name: widget.studentName,
          fatherName: widget.fatherName,
          motherName: widget.motherName,
          collegeName: widget.collegeName,
          examRoll: widget.examRoll,
          registrationNo: widget.registrationNo,
          courseName: 'CIS',
          semesters: allSemesters, // Changed from years
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TranscriptScreen(student: student),
          ),
        );
      }
    }
  }
}




//TRANSCRIPT SCREEN OR FINAL SCREEN FOR THE OUTPUT 
class TranscriptScreen extends StatefulWidget {
  final Student student;

  const TranscriptScreen({
    super.key,
    required this.student,
  });

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {

   @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff3a792e),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Image.asset(
                'assets/images/UFV-50.png',
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            studentInfoTable(),
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Course wise Letter Grade',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            studentGradeTable(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const StudentInfoForm(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Start New Transcript'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget studentInfoTable() {
    return Card(
      elevation: 2,
      shadowColor: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          border: TableBorder.all(
            color: Colors.green.withOpacity(0.4),
            width: 1,
          ),
          children: [
            TableRows('Student\'s Name', widget.student.name),
            TableRows('Father\'s Name', widget.student.fatherName),
            TableRows('Mother\'s Name', widget.student.motherName),
            TableRows('Name of College', widget.student.collegeName),
            TableRows('Exam. Roll', widget.student.examRoll),
            TableRows('Registration No.', widget.student.registrationNo),
            TableRows('Course Name', widget.student.courseName),
            TableRows('Total Credit', widget.student.totalCredits.toString()),
            TableRows('Earned Credit', widget.student.totalCredits.toString()),
            TableRows('Result',
                'CGPA: ${widget.student.calculateCGPA().toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  TableRow TableRows(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value),
          ),
        ),
      ],
    );
  }

  int maxCoursesInSemester() {
    return widget.student.semesters.fold(
        0,
        (max, semester) =>
            semester.courses.length > max ? semester.courses.length : max);
  }

  Widget studentSemesterHeader(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget studentGradeTable() {
  return Column(
    children: widget.student.semesters.map((semester) {
      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Semester Header
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.green,
              child: Text(
                'Semester ${semester.number}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Course Table Header
            Table(
              border: TableBorder.all(color: Colors.green, width: 1),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  children: [
                    studentHeaderCell('Course Code'),
                    studentHeaderCell('Grade'),
                    studentHeaderCell('Score'),
                    studentHeaderCell('GPV'),
                    studentHeaderCell('CGP'),
                  ],
                ),
              ],
            ),
            // Course Rows
            ...semester.courses.map((course) {
              return Table(
                border: TableBorder.all(color: Colors.grey, width: 1),
                children: [
                  TableRow(
                    children: [
                      studentGradeCell(course.code),
                      studentGradeCell(course.letterGrade),
                      studentGradeCell(course.NumberScore.toString()),
                      studentGradeCell(course.gpv.toStringAsFixed(2)),
                      studentGradeCell(course.qualityPoint.toStringAsFixed(2)),
                    ],
                  ),
                ],
              );
            }).toList(),
            // Semester GPA
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.green,
              child: Text(
                'GPA: ${semester.calculateGPA().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

  Widget studentGradeHeaders() {
    return Table(
      children: [
        TableRow(
          children: [
            studentHeaderCell('Course Code'),
            studentHeaderCell('Grade'),
            studentHeaderCell('Score'),
            studentHeaderCell('GPV'),
            studentHeaderCell('CGP'),
          ],
        ),
      ],
    );
  }

  Widget studentHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget studentCourseGradeRow(Course course) {
    return Table(
      children: [
        TableRow(
          children: [
            studentGradeCell(course.code),
            studentGradeCell(course.letterGrade),
            studentGradeCell(course.NumberScore.toString()),
            studentGradeCell(course.gpv.toStringAsFixed(2)),
            studentGradeCell(course.qualityPoint.toStringAsFixed(2)),
          ],
        ),
      ],
    );
  }

  Widget studentGradeCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}





// CLASSES FOR THE LISTS OF SEMESTERS AND FOR THE GPA /CGPA CALCULATIONS.
class Course {
  final String code;
  final int credits;
  final String letterGrade;
  final int NumberScore;
  final double qualityPoint;
  late final double gpv;

  Course({
    required this.code,
    required this.credits,
    required this.letterGrade,
    required this.qualityPoint,
    required this.NumberScore,
  }) {
    gpv = calculateGPV();
  }

  double calculateGPV() {
    final gradePoints = {
      'A+': 4.33,
      'A': 4.00,
      'A-': 3.67,
      'B+': 3.33,
      'B': 3.00,
      'B-': 2.67,
      'C+': 2.33,
      'C': 2.00,
      'C-': 1.67,
      'D': 1.00,
      'F': 0.00,
    };
    return gradePoints[letterGrade] ?? 0.0;
  }

  double calculateGPVNumber(String grade) {
    final gradePointsScore = {
      'A+': 4.33,
      'A': 4.00,
      'A-': 3.67,
      'B+': 3.33,
      'B': 3.00,
      'B-': 2.67,
      'C+': 2.33,
      'C': 2.00,
      'C-': 1.67,
      'D': 1.00,
      'F': 0.00
    };
    return gradePointsScore[grade] ?? 0.00;
  }
}

class Semester {
  final int number;
  final List<Course> courses;

  Semester({
    required this.number,
    required this.courses,
  });

  double calculateGPA() {
    if (courses.isEmpty) return 0.0;
    final totalCredits =
        courses.fold<int>(0, (sum, course) => sum + course.credits);
    final weightedSum = courses.fold<double>(
        0, (sum, course) => sum + (course.credits * course.gpv));
    return totalCredits > 0 ? weightedSum / totalCredits : 0.0;
  }

  bool validateCredits() {
    final totalCredits =
        courses.fold<int>(0, (sum, course) => sum + course.credits);
    return totalCredits >= 9 && totalCredits <= 20;
  }
}

class Year {
  final int number;
  final List<Semester> semesters;

  Year({
    required this.number,
    required this.semesters,
  });

  List<Course> get allCourses {
    return semesters.expand((semester) => semester.courses).toList();
  }

  double calculateGPA() {
    if (semesters.isEmpty) return 0.0;
    double totalWeightedGPA = 0.0;
    int totalCredits = 0;
    for (var semester in semesters) {
      for (var course in semester.courses) {
        totalWeightedGPA += course.credits * course.gpv;
        totalCredits += course.credits;
      }
    }
    return totalCredits > 0 ? totalWeightedGPA / totalCredits : 0.0;
  }
}

class Student {
  final String name;
  final String fatherName;
  final String motherName;
  final String collegeName;
  final String examRoll;
  final String registrationNo;
  final String courseName;
  final List<Semester> semesters;

  Student({
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.collegeName,
    required this.examRoll,
    required this.registrationNo,
    required this.courseName,
    required this.semesters,
  });

  double calculateCGPA() {
    if (semesters.isEmpty) return 0.0;
    double totalWeightedGPA = 0.0;
    int totalCredits = 0;

    for (var semester in semesters) {
      for (var course in semester.courses) {
        totalWeightedGPA += course.credits * course.gpv;
        totalCredits += course.credits;
      }
    }

    return totalCredits > 0 ? totalWeightedGPA / totalCredits : 0.0;
  }

  int get totalCredits {
    return semesters.fold<int>(
        0,
        (sum, semester) =>
            sum +
            semester.courses.fold<int>(
                0, (courseSum, course) => courseSum + course.credits));
  }
}
