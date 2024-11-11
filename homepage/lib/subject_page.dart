import 'package:flutter/material.dart';
import 'package:lms_homepage/activity_details.dart';
import 'package:lms_homepage/archive_class.dart';
import 'package:lms_homepage/create_post_page.dart';
import 'package:lms_homepage/edit_profile_page.dart';
import 'package:lms_homepage/login_page.dart';
import 'main.dart';
import 'upload_grade.dart';

class SubjectPage extends StatefulWidget {
  final String teacherId;

  const SubjectPage({super.key, required this.teacherId});

  @override
  // ignore: library_private_types_in_public_api
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  bool isSidebarExpanded = false;
  bool isHovering = false;

  final ScrollController _scrollController = ScrollController();
  bool showLeftArrow = false;
  bool showRightArrow = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    setState(() {
      // Show Left Arrow if not at the start
      showLeftArrow = currentScroll > 0;
      // Show Right Arrow if not at the end
      showRightArrow = currentScroll < maxScroll;
    });
  }

  void _scrollToLeft() {
    _scrollController.animateTo(
      _scrollController.position.pixels - 200, // Adjust the amount to scroll
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _scrollToRight() {
    _scrollController.animateTo(
      _scrollController.position.pixels + 200, // Adjust the amount to scroll
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
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
                                    ? const Color.fromRGBO(44, 155, 68, 1)
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
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title Section with Logo
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/ccst.jpg'),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "College of Computer Studies and Technology",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "CC214 - Data Structure and Algorithm",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "BSIT - 2C",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.home),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DashboardScreen(
                                                teacherId: ''),
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

                          const SizedBox(height: 20),

                          // Learning Materials Section and Add Content
                          const Text(
                            "Learning Materials:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 120,
                            child: Row(
                              children: [
                                Visibility(
                                  visible: showLeftArrow,
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_left),
                                    iconSize: 30,
                                    onPressed: _scrollToLeft,
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller: _scrollController,
                                    child: Row(
                                      children: List.generate(9, (index) {
                                        final week = 'Week ${index + 1}';
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: GestureDetector(
                                            onTap: () =>
                                                _showWeekModal(context, week),
                                            child: Card(
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: SizedBox(
                                                width: 140,
                                                height: 100,
                                                child: Center(
                                                  child: Text(
                                                    week,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: showRightArrow,
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_right),
                                    iconSize: 30,
                                    onPressed: _scrollToRight,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Input Bar for Teacher to Upload Activity/Announcement
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CreatePostPage(teacherId: ''),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage('assets/aliceg.jpg'),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Post an Activity or Announcement...',
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(102, 102, 102, 1)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Activity Post Box
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ActivityDetailsPage(teacherId: ''),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      // Teacher's Image
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            AssetImage('assets/aliceg.jpg'),
                                      ),
                                      SizedBox(width: 10),
                                      // Teacher's Name and Date
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Alice Guo",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4),
                                          Text("2024-10-25",
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Activity Details
                                  const Text(
                                    "This is a brief description of the activity posted by the teacher.",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Activity #1",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 10),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ActivityDetailsPage(
                                                    teacherId: ''),
                                          ),
                                        );
                                      },
                                      child: const Text("See Details",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  102, 102, 102, 1))),
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }

  void _showWeekModal(BuildContext context, String week) {
    List<Map<String, String>> modules = []; // List to hold added modules

    void addModule() {
      setState(() {
        modules.add({'name': 'Module ${modules.length + 1}'});
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              contentPadding: const EdgeInsets.all(20),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    week,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.grey),
                    onPressed: addModule, // Add new module when clicked
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Using a ListView builder for a dynamic list
                    for (var module in modules) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.insert_drive_file,
                                    size: 30),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                module['name']!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Additional Learning Materials",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/gdrive.png', // GDrive asset
                                        width: 30,
                                        height: 30,
                                      ),
                                      onPressed: () {
                                        // Handle Google Drive action
                                      },
                                    ),
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/yt.png', // YouTube asset
                                        width: 30,
                                        height: 30,
                                      ),
                                      onPressed: () {
                                        // Handle YouTube action
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.link,
                                          color: Colors.black),
                                      iconSize: 30,
                                      onPressed: () {
                                        // Handle link action
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add,
                                          color: Colors.grey),
                                      iconSize: 30,
                                      onPressed: () {
                                        // Handle add new content
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                          thickness: 1,
                          color: Colors.grey), // Separator line for modules
                    ],
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
