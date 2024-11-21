import 'package:flutter/material.dart';
import 'package:lms_homepage/archive_class.dart';
import 'package:lms_homepage/edit_profile_page.dart';
import 'package:lms_homepage/subject_page.dart';
import 'upload_grade.dart';
import 'package:lms_homepage/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://eqaqizznngarxghlrpul.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVxYXFpenpubmdhcnhnaGxycHVsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzAyODk5MzgsImV4cCI6MjA0NTg2NTkzOH0.gCKoYLBnY0em8c0WnaWFCdukjgMvWiOmZgGzIstb8Kk',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.black),
          useMaterial3: true,
        ),
        home: const LoginPage());
  }
}

class DashboardScreen extends StatefulWidget {
  final String teacherId;

  const DashboardScreen({super.key, required this.teacherId});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isHovering = false;
  bool isHoveringUpload = false;
  bool isHoveringArchive = false;
  bool isHoveringLogout = false;

  List<Map<String, dynamic>> classDataList = [];

  @override
  void initState() {
    super.initState();
    print("dashboard is initialized with the ID: ${widget.teacherId}");
    fetchClassData();
  }

  Future<void> fetchClassData() async {
    try {
      final teacherData = await Supabase.instance.client
          .from('teacher')
          .select('course_id')
          .eq('id', widget.teacherId)
          .single();

      if (teacherData['course_id'] == null) {
        print("Course ID is not found for teacher.");
        return;
      }

      final teacherCourseId = teacherData['course_id'];

      final courseData = await Supabase.instance.client
          .from('college_course')
          .select('name')
          .eq('id', teacherCourseId)
          .single();

      if (courseData['name'] == null) {
        print("Course not found.");
        return;
      }

      final courseName = courseData['name'];

      // Step 3: Fetch sections related to the teacher's course_id
      final data = await Supabase.instance.client
          .from('section')
          .select(
              'name, year_number, college_program(name, college_department(name))')
          .eq('course_id', teacherCourseId); // Assuming section has 'course_id'

      if (data.isEmpty) {
        print("No sections found for course_id: $teacherCourseId");
        return;
      }

      // Step 4: Process the data
      setState(() {
        classDataList = data.map((item) {
          return {
            'class_name': item['name'],
            'year_number': item['year_number'],
            'program_name': item['college_program']['name'],
            'department_name': item['college_program']['college_department']
                ['name'],
            'course_name': courseName, // Add course name to the class data
          };
        }).toList();
      });
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching class data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 70, // Fixed width for the sidebar
            color: const Color.fromARGB(
                255, 44, 155, 68), // Fixed color for the sidebar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile Picture with GestureDetector for navigation
                    Tooltip(
                      message: 'Edit Profile',
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
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/aliceg.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Upload Grades Button
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          isHoveringUpload = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          isHoveringUpload = false;
                        });
                      },
                      child: Tooltip(
                        message: 'Upload Grades',
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UploadGradePage(
                                    teacherId: 'teacherId'),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.upload,
                            size: 40,
                            color: isHoveringUpload
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : const Color.fromARGB(255, 0, 0, 0),
                            shadows: isHoveringUpload
                                ? [
                                    const BoxShadow(
                                        color:
                                            Color.fromARGB(255, 69, 238, 106),
                                        blurRadius: 10)
                                  ]
                                : [],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Archive Courses Button
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          isHoveringArchive = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          isHoveringArchive = false;
                        });
                      },
                      child: Tooltip(
                        message: 'Archive Courses',
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ArchiveClassScreen(teacherId: ''),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.archive,
                            size: 40,
                            color: isHoveringArchive
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : const Color.fromARGB(255, 0, 0, 0),
                            shadows: isHoveringArchive
                                ? [
                                    const BoxShadow(
                                        color:
                                            Color.fromARGB(255, 69, 238, 106),
                                        blurRadius: 10)
                                  ]
                                : [],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        isHoveringLogout = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        isHoveringLogout = false;
                      });
                    },
                    child: Tooltip(
                      message: 'Log Out',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.logout,
                          size: 40,
                          color: isHoveringLogout
                              ? Colors.white
                              : const Color.fromARGB(255, 0, 0, 0),
                          shadows: isHoveringLogout
                              ? [
                                  const BoxShadow(
                                      color: Color.fromARGB(255, 69, 238, 106),
                                      blurRadius: 10)
                                ]
                              : [],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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

                  // Class Cards
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount:
                          classDataList.length, // Use fetched data length
                      itemBuilder: (context, index) {
                        final classData = classDataList[index];

                        return classCard(
                          classData['class_name']!, // Pass class name
                          classData['year_number']!, // Pass year number
                          classData['program_name']!, // Pass program name
                          classData['department_name']!,
                          classData['course_name']!, // Pass department name
                          widget.teacherId, // Pass teacherId
                        );
                      },
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

  Widget classCard(String className, String yearNumber, String courseName,
      String programName, String departmentName, String teacherId) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectPage(
              teacherId: teacherId,
              className: className,
              section: yearNumber,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/ccst.jpg'),
                ),
                title: Text(
                  departmentName, // Display department name
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      courseName,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      "$programName $yearNumber $className",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
