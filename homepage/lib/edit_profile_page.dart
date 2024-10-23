import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
          // Main Content without Scroll
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header (Fixed Alignment)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20), // Added top padding
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Aligning items centrally
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundImage:
                                  const AssetImage('assets/plsp.png'),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Pamantasan ng Lungsod ng San Pablo",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                    height:
                                        2), // Add spacing between lines for clarity
                                Text(
                                  'Brgy. San Jose, San Pablo City',
                                  style: TextStyle(
                                      fontSize:
                                          12), // Increased font size slightly
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            // Name Fields
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField('First Name'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: buildTextField('Middle Name'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: buildTextField('Last Name'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField('Email'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: buildTextField('Contact Number'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: buildTextField('Sex'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField('Address'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: buildTextField('City'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField('Zip Code'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: buildTextField('Province'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: buildTextField('Nationality'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField('Password',
                                      isPassword: true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('assets/aliceg.jpg'),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Profile picture change functionality
                            },
                            child: const Text('Change Picture'),
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
                        // Save functionality
                      },
                      child: const Text('Save Changes'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Text Field widget with optional password feature
  Widget buildTextField(String labelText, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior:
              FloatingLabelBehavior.always, // Always outside the field
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
    ),
    home: const EditProfilePage(),
  ));
}
