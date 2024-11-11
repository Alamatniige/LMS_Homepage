import 'package:flutter/material.dart';
import 'package:lms_homepage/archive_class.dart';
import 'package:lms_homepage/edit_profile_page.dart';
import 'package:lms_homepage/login_page.dart';
import 'package:lms_homepage/main.dart';
import 'package:lms_homepage/upload_grade.dart';

class GradeInputPage extends StatefulWidget {
  final String className;
  final String section;
  final String room;

  const GradeInputPage({
    Key? key,
    required this.className,
    required this.section,
    required this.room,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GradeInputPageState createState() => _GradeInputPageState();
}

class _GradeInputPageState extends State<GradeInputPage> {
  bool isSidebarExpanded = false;
  bool isHovering = false;

  final List<TextEditingController> _midtermGradeControllers = [];
  final List<TextEditingController> _finalsGradeControllers = [];
  final List<bool> _isLocked = [];
  final List<bool> _isSaved = []; // Track if the grades are saved

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      _midtermGradeControllers.add(TextEditingController());
      _finalsGradeControllers.add(TextEditingController());
      _isLocked.add(false);
      _isSaved.add(false); // Initialize saved state as false
    }
  }

  @override
  void dispose() {
    for (var controller in _midtermGradeControllers) {
      controller.dispose();
    }
    for (var controller in _finalsGradeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          MouseRegion(
            onEnter: (_) {
              setState(() {
                isSidebarExpanded = true;
              });
            },
            onExit: (_) {
              setState(() {
                isSidebarExpanded = false;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSidebarExpanded ? 200 : 70,
              color: isSidebarExpanded
                  ? const Color.fromARGB(255, 44, 155, 68)
                  : Colors.green[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      // Profile Picture
                      CircleAvatar(
                        radius: isSidebarExpanded ? 30 : 20,
                        backgroundImage: const AssetImage('assets/aliceg.jpg'),
                      ),
                      if (isSidebarExpanded) const SizedBox(height: 10),
                      if (isSidebarExpanded)
                        MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              isHovering = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              isHovering = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfilePage(teacherId: ''),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isHovering
                                    ? Colors.green[700]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),

                      // Upload Grades Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UploadGradePage(teacherId: ''),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const Icon(Icons.upload, size: 40),
                            if (isSidebarExpanded) const Text("Upload Grades"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Archive Courses Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ArchiveClassScreen(teacherId: ''),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const Icon(Icons.archive, size: 40),
                            if (isSidebarExpanded)
                              const Text("Archive Courses"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.logout, size: 40),
                          if (isSidebarExpanded) const Text("Log Out"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: AssetImage('assets/plsp.png'),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pamantasan ng Lungsod ng San Pablo",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Brgy. San Jose, San Pablo City',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              'Tel No: (049) 536-7830',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              'Email Address: plspofficial@plsp.edu.ph',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      // Home Button
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.home),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DashboardScreen(teacherId: ''),
                              ),
                            );
                          },
                          color: const Color.fromRGBO(44, 155, 68, 1),
                          tooltip: 'Go to Home',
                          iconSize: 40,
                        ),
                      ),
                    ],
                  ),

                  // Class Details
                  Text(
                    "${widget.className} - ${widget.section}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Room: ${widget.room}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),

                  // Midterm Labels
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 100),
                      Text(
                        "Midterm",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 255),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Expanded(
                    child: ListView.builder(
                      itemCount: _midtermGradeControllers.length,
                      itemBuilder: (context, index) {
                        return _buildStudentGradeTable(index);
                      },
                    ),
                  ),

                  // Save and Submit Buttons
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Save All Grades Button with Icon
                        ElevatedButton.icon(
                          onPressed: _saveGrades,
                          icon:
                              const Icon(Icons.save, color: Color(0xFF2C9B44)),
                          label: const Text(
                            "Save All Grades",
                            style: TextStyle(color: Color(0xFF2C9B44)),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Submit Grades Button with Icon
                        ElevatedButton.icon(
                          onPressed: _submitGrades,
                          icon:
                              const Icon(Icons.send, color: Color(0xFF2C9B44)),
                          label: const Text(
                            "Submit Grades",
                            style: TextStyle(color: Color(0xFF2C9B44)),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentGradeTable(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Table(
        children: [
          TableRow(
            children: [
              // Student Image and Name
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/aliceg.jpg'),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Alice Guo",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              // Midterm Grade Dropdown
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  value: _midtermGradeControllers[index].text.isEmpty
                      ? null
                      : _midtermGradeControllers[index].text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  items: [
                    '1.00',
                    '1.25',
                    '1.50',
                    '1.75',
                    '2.00',
                    '2.25',
                    '2.50',
                    '2.75',
                    '3.00',
                    '3.25',
                    '3.50',
                    '3.75',
                    '4.00',
                    '5.00',
                    'FAILED',
                    'INC',
                    'UW',
                    'OW'
                  ].map((String grade) {
                    return DropdownMenuItem<String>(
                      value: grade,
                      child: Text(grade),
                    );
                  }).toList(),
                  onChanged:
                      !_isLocked[index] // Only allow change if not locked
                          ? (value) {
                              setState(() {
                                _midtermGradeControllers[index].text =
                                    value ?? '';
                              });
                            }
                          : null,
                  isExpanded: true,
                ),
              ),
            ],
          ),
        ],
        border: const TableBorder.symmetric(
          inside: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
    );
  }

  void _saveGrades() {
    // Save the inputted grades
    for (int i = 0; i < _midtermGradeControllers.length; i++) {
      String midtermGrade = _midtermGradeControllers[i].text;
      String finalsGrade = _finalsGradeControllers[i].text;

      // Mark the grade as saved
      _isSaved[i] = true; // Mark as saved after successful input
      // ignore: avoid_print
      print(
          "Saved Student ${i + 1} - Midterm: $midtermGrade, Finals: $finalsGrade");
    }

    // Show confirmation dialog for saving grades
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Grades Saved"),
        content: const Text("All grades have been successfully saved."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _submitGrades() async {
    // Show confirmation dialog for submitting grades
    bool confirmSubmit = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Submission"),
          content: const Text(
              "Are you sure you want to submit all grades? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel submission
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm submission
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );

    if (confirmSubmit) {
      // Proceed with grade submission if confirmed
      setState(() {
        for (int i = 0; i < _midtermGradeControllers.length; i++) {
          // Lock the grades by making the input fields uneditable
          _isLocked[i] = true;
        }
      });

      // Show confirmation dialog for successful submission
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Grades Submitted"),
          content: const Text("All grades have been successfully submitted."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(
                    context); // Optional: Navigate back after submission
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
