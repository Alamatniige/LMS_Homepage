import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSidebarExpanded = false;

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
              color: Colors.green[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      // Profile Picture
                      CircleAvatar(
                        radius: isSidebarExpanded ? 30 : 20,
                        backgroundImage: AssetImage('assets/aliceg.jpg'),
                      ),
                      if (isSidebarExpanded) const SizedBox(height: 10),
                      if (isSidebarExpanded)
                        const Text(
                          "Edit Profile",
                          style: TextStyle(fontSize: 16),
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
                  Center(
                    child: const Row(
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
                        crossAxisCount: 3, // Adjusted the number of columns
                        childAspectRatio: 1.5, // Adjusted the aspect ratio
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final classData = [
                          {
                            "name": "Data Structure and Algorithm",
                            "section": "BSIT - 2C",
                            "room": "203"
                          },
                          {
                            "name": "Project Management",
                            "section": "BSIT - 3D",
                            "room": "203"
                          },
                          {
                            "name": "Living in IT Era",
                            "section": "BSIT - 1A",
                            "room": "210"
                          },
                          {
                            "name": "Introduction to Computing",
                            "section": "BSIT - 1D",
                            "room": "207"
                          }
                        ][index];

                        return classCard(classData['name']!,
                            classData['section']!, classData['room']!);
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
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/ccst.jpg'),
              ),
              title: const Text(
                "College of Computer Studies and Technology",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12), // Smaller font size for the dept name
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                      height:
                          12), // Add some space between the dept name and the course details
                  Text(
                    className,
                    style: const TextStyle(
                        fontSize:
                            10), // Smaller font size for the course details
                  ),
                  Text(
                    "$section\nRoom $room",
                    style: const TextStyle(
                        fontSize:
                            10), // Smaller font size for the course details
                  ),
                ],
              ),
              trailing: PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'open') {
                    print('Open Class');
                  } else if (value == 'archive') {
                    print('Archive Class');
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'open', child: Text("Open Class")),
                  const PopupMenuItem(
                      value: 'archive', child: Text("Archive Class")),
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
    home: const DashboardScreen(),
  ));
}
