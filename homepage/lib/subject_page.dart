import 'package:flutter/material.dart';
import 'package:lms_homepage/activity_details.dart';
import 'package:lms_homepage/archive_class.dart';
import 'package:lms_homepage/create_post_page.dart';
import 'package:lms_homepage/edit_profile_page.dart';
import 'package:lms_homepage/login_page.dart';
import 'main.dart';
import 'upload_grade.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubjectPage extends StatefulWidget {
  final String teacherId;
  final String className;
  final String section;

  const SubjectPage({
    super.key,
    required this.teacherId,
    required this.className,
    required this.section,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  bool isSidebarExpanded = false;
  bool isHovering = false;
  bool isHoveringUpload = false;
  bool isHoveringArchive = false;
  bool isHoveringLogout = false;

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
                  // Title Section with Logo (Header of the Page)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Space out the items
                        children: [
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Center logo and text
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundImage:
                                      AssetImage('assets/ccst.jpg'),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Center the text
                                  children: [
                                    Text(
                                      "College of Computer Studies and Technology",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "CC214 - Data Structure and Algorithm",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "BSIT - 2C",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
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
                                  builder: (context) => DashboardScreen(
                                      teacherId: widget.teacherId),
                                ),
                              );
                            },
                            color: const Color.fromRGBO(44, 155, 68, 1),
                            tooltip: 'Go to Home',
                            iconSize: 40,
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
                                  builder: (context) => CreatePostPage(
                                    teacherId: widget.teacherId,
                                    className: widget
                                        .className, // Pass the className from widget
                                    section: widget.section,
                                  ),
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
                                  builder: (context) => ActivityDetailsPage(
                                    teacherId: widget.teacherId,
                                    className: widget
                                        .className, // Pass the className from widget
                                    section: widget
                                        .section, // Pass the section from widget
                                  ),
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
                                                ActivityDetailsPage(
                                              teacherId: widget.teacherId,
                                              className: widget
                                                  .className, // Pass the className from widget
                                              section: widget
                                                  .section, // Pass the section from widget
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "See Details",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1)),
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
            ),
          ),
        ],
      ),
    );
  }

  void _showWeekModal(BuildContext context, String week) {
    List<Map<String, String>> modules = [];
    final TextEditingController linkController = TextEditingController();
    bool isAddingLink = false;

    Future<void> insertLinkToDatabase(String link) async {
      if (widget.teacherId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Teacher ID is required.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      print("Teacher ID: '${widget.teacherId}'");

      int? teacherIdInt = int.tryParse(widget.teacherId);
      if (teacherIdInt == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Teacher ID.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      try {
        final response = await Supabase.instance.client.from('module').insert({
          'modulename': link,
          'filepath': link,
          'teacherid': teacherIdInt,
        });

        if (response != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Link uploaded successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
          modules.add({'name': link}); // Add the link to the displayed list
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading link: ${e.toString()}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
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
                    onPressed: () {
                      setState(() {
                        isAddingLink = !isAddingLink;
                      });
                    },
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isAddingLink) ...[
                      TextField(
                        controller: linkController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Module Link',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          String link = linkController.text.trim();
                          if (link.isNotEmpty) {
                            await insertLinkToDatabase(link);
                            setState(() {
                              linkController.clear();
                              isAddingLink = false; // Hide field after save
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid link.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: const Text("Save Link"),
                      ),
                    ],
                    const SizedBox(height: 10),
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
                                child: const Icon(Icons.link, size: 30),
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
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
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
