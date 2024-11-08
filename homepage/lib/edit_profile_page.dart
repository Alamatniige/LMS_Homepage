import 'package:flutter/material.dart';
import 'package:lms_homepage/archive_class.dart';
import 'package:lms_homepage/login_page.dart';
import 'package:lms_homepage/main.dart';
import 'package:lms_homepage/upload_grade.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isSidebarExpanded = false;
  bool isHovering = false;

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
                                  builder: (context) => const EditProfilePage(),
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
                              builder: (context) => const UploadGradePage(),
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
                              builder: (context) => const ArchiveClassScreen(),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const Row(
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
                              SizedBox(height: 2),
                              Text(
                                'Brgy. San Jose, San Pablo City',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Tel No: (049) 536-7830',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Email Address: plspofficial@plsp.edu.ph',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Back Button Row
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.home),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardScreen(),
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
                ),
                const SizedBox(height: 20),
                // Profile Page Content
                const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildTextField(
                                          'First Name',
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: buildTextField(
                                          'Middle Name',
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: buildTextField(
                                          'Last Name',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildTextField(
                                          'Email',
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: buildTextField(
                                          'Contact Number',
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: buildTextField(
                                          'Sex',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildTextField(
                                          'Address',
                                          hintText:
                                              'Street No./Name, House/Building No.',
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: buildTextField(
                                          'City',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildTextField(
                                          'Zip Code',
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: buildTextField(
                                          'Province',
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: buildTextField(
                                          'Nationality',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                const CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      AssetImage('assets/aliceg.jpg'),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    // Change picture action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  child: const Text(
                                    'Change Picture',
                                    style: TextStyle(
                                      color: Color(0xFF2CB944),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Save Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Save changes action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(
                                color: Color(0xFF2CB944),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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

  Widget buildTextField(String labelText, {String hintText = ''}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 102, 102, 102),
          ),
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 102, 102, 102).withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(102, 102, 102, 1)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2CB944)),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EditProfilePage(),
  ));
}
