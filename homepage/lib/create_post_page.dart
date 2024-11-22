import 'package:flutter/material.dart';
import 'package:lms_homepage/archive_class.dart';
import 'package:lms_homepage/edit_profile_page.dart';
import 'package:lms_homepage/login_page.dart';
import 'package:lms_homepage/subject_page.dart';
import 'package:lms_homepage/upload_grade.dart';

class CreatePostPage extends StatefulWidget {
  final String teacherId;
  final String className;
  final String section;
  final String courseName;
  final String programName;
  final String departmentName;
  final String yearNumber;

  const CreatePostPage({
    super.key,
    required this.teacherId,
    required this.className,
    required this.section,
    required this.courseName,
    required this.programName,
    required this.departmentName,
    required this.yearNumber,
  }); // Update the constructor to accept teacherId

  @override
  // ignore: library_private_types_in_public_api
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  bool isSidebarExpanded = false;
  bool isHovering = false;
  bool isHoveringUpload = false;
  bool isHoveringArchive = false;
  bool isHoveringLogout = false;

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
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Space out the items
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center logo and text
                            children: [
                              const CircleAvatar(
                                radius: 26,
                                backgroundImage: AssetImage('assets/ccst.jpg'),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // Center the text
                                children: [
                                  Text(
                                    widget.departmentName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height:
                                          1.0, // Adjust this value to reduce spacing
                                    ),
                                  ),
                                  Text(
                                    widget.programName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height:
                                          0.1, // Adjust this value to reduce spacing
                                    ),
                                  ),
                                  Text(
                                    '${widget.courseName} ${widget.yearNumber}-${widget.className}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height:
                                          2.0, // Adjust this value to reduce spacing
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubjectPage(
                                    teacherId: widget.teacherId,
                                    className: widget.className,
                                    section: widget.section,
                                    courseName: widget.courseName,
                                    programName: widget.programName,
                                    departmentName: widget.departmentName,
                                    yearNumber: widget.yearNumber),
                              ),
                            );
                          },
                          color: const Color.fromRGBO(44, 155, 68, 1),
                          tooltip: 'Go Back',
                          iconSize: 40,
                        ),
                      ],
                    ),
                  ],
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Input field with teacher's image
                        Stack(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Post an Activity or Announcement',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(left: 60, top: 15),
                              ),
                              maxLines: 6,
                            ),
                            const Positioned(
                              left: 10,
                              top: 10,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/aliceg.jpg'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Icons for Google Drive, YouTube, Upload, and Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Image.asset(
                                'assets/gdrive.png',
                                width: 40,
                                height: 40,
                              ),
                              onPressed: () {
                                // Implement Google Drive functionality
                              },
                            ),
                            IconButton(
                              icon: Image.asset(
                                'assets/yt.png',
                                width: 40,
                                height: 40,
                              ),
                              onPressed: () {
                                // Implement YouTube functionality
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.upload_file, size: 30),
                              onPressed: () {
                                // Implement file upload functionality
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.link, size: 30),
                              onPressed: () {
                                // Implement link functionality
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Publish button aligned to the right
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement publish functionality
                              // You can use widget.teacherId here if needed
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              backgroundColor:
                                  const Color.fromRGBO(44, 155, 68, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Publish',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
