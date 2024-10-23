import 'package:flutter/material.dart';

class UploadGradePage extends StatefulWidget {
  const UploadGradePage({super.key});

  @override
  _UploadGradePageState createState() => _UploadGradePageState();
}

class _UploadGradePageState extends State<UploadGradePage> {
  bool isSidebarExpanded = false;
  bool isHovering = false; // For hover effect on Edit Profile

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
                  ? const Color.fromARGB(255, 55, 165, 60)
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
                                      const Placeholder(), // Add your EditProfilePage here
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
                      const Icon(Icons.upload, size: 40),
                      if (isSidebarExpanded) const Text("Upload Grades"),
                      const SizedBox(height: 20),
                      const Icon(Icons.archive, size: 40),
                      if (isSidebarExpanded) const Text("Archive Courses"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        const Icon(Icons.logout, size: 40),
                        if (isSidebarExpanded) const Text("Log Out"),
                      ],
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),

                  // Title for Upload Grades
                  const Text(
                    "Upload Grades",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Select Course:",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Class Cards for selecting courses to upload grades
                  Expanded(
                    child: ListView(
                      children: [
                        classCard(
                            "Data Structure and Algorithm", "BSIT - 2C", "203"),
                        classCard("Project Management", "BSIT - 3D", "203"),
                        classCard("Living in IT Era", "BSIT - 1A", "210"),
                        classCard(
                            "Introduction to Computing", "BSIT - 1D", "207"),
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

  Widget classCard(String className, String section, String room) {
    return Card(
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
              title: const Text(
                "College of Computer Studies and Technology",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    className,
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text(
                    "$section\nRoom $room",
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      iconTheme: const IconThemeData(color: Colors.black),
      useMaterial3: true,
    ),
    home: const UploadGradePage(),
  ));
}
