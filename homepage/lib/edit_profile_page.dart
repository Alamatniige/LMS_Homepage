import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading assets
import 'package:lms_homepage/archive_class.dart';
import 'package:lms_homepage/login_page.dart';
import 'package:lms_homepage/main.dart';
import 'package:lms_homepage/upload_grade.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class EditProfilePage extends StatefulWidget {
  final String teacherId; // Declare teacherId

  const EditProfilePage({Key? key, required this.teacherId}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isSidebarExpanded = false;
  bool isHovering = false;
  bool isHoveringUpload = false;
  bool isHoveringArchive = false;
  bool isHoveringLogout = false;

  // Dropdown values
  String? region;
  String? province;
  String? city;

  List<Region> regions = [];
  List<Province> provinces = [];
  List<City> cities = [];

  String? selectedCityCode;

  final TextEditingController regionController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
    print("dashboard is initialized with the ID: ${widget.teacherId}");
  }

  // Load the JSON data from assets
  Future<void> loadData() async {
    try {
      final regionData = await loadJsonData('assets/region.json');
      final provinceData = await loadJsonData('assets/province.json');
      final cityData = await loadJsonData('assets/city.json');

      setState(() {
        regions = regionData.map((item) => Region.fromJson(item)).toList();
        provinces =
            provinceData.map((item) => Province.fromJson(item)).toList();
        cities = cityData.map((item) => City.fromJson(item)).toList();
      });
    } catch (e) {
      // ignore: avoid_print
      print("Error loading data: $e");
    }
  }

  Future<List<dynamic>> loadJsonData(String path) async {
    String jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }

  void updateProvinces() {
    setState(() {
      provinces = provinces
          .where((province) =>
              province.regionCode ==
              regions.firstWhere((r) => r.regionName == region).regionCode)
          .toList();
      city = null; // Reset city
      selectedCityCode = null; // Reset city code
      cityController.clear();
    });
  }

  // Method to update cities when a province is selected
  void updateCities() {
    setState(() {
      cities = cities
          .where((city) =>
              city.provinceCode ==
              provinces
                  .firstWhere((p) => p.provinceName == province)
                  .provinceCode)
          .toList();
      selectedCityCode = null; // Reset city code
      cityController.clear();
    });
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centers the content horizontally
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Vertically centers the content
                        children: [
                          // This will center the photo and text in the row
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Centers photo and text
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Centers photo and text vertically
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundImage:
                                      AssetImage('assets/plsp.png'),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Left-aligns the text
                                  children: [
                                    Text(
                                      "Pamantasan ng Lungsod ng San Pablo",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
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

                          // Back button aligned to the right
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
                      )),
                      const SizedBox(height: 10),
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ), // Profile Page Content
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
                                  // Profile Picture Section
                                  Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            AssetImage('assets/aliceg.jpg'),
                                      ),
                                      const SizedBox(height: 5),
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

                                  const SizedBox(height: 20),
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
                                          'Phone Number',
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: buildTextField('Adress',
                                            hintText:
                                                'House/Building No., Street, Barangay'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TypeAheadField<String?>(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            controller: regionController,
                                            decoration: const InputDecoration(
                                              labelText: 'Region',
                                              border: OutlineInputBorder(),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                            ),
                                          ),
                                          suggestionsCallback: (pattern) {
                                            return regions
                                                .where((region) => region
                                                    .regionName
                                                    .toLowerCase()
                                                    .contains(
                                                        pattern.toLowerCase()))
                                                .map((region) =>
                                                    region.regionName)
                                                .toList();
                                          },
                                          itemBuilder:
                                              (context, String? suggestion) {
                                            return ListTile(
                                              title: Text(suggestion ?? ""),
                                            );
                                          },
                                          onSuggestionSelected:
                                              (String? suggestion) {
                                            setState(() {
                                              region = suggestion;
                                              regionController.text =
                                                  suggestion ?? "";
                                              updateProvinces();
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: TypeAheadField<String?>(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            controller: provinceController,
                                            decoration: const InputDecoration(
                                              labelText: 'Province',
                                              border: OutlineInputBorder(),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                            ),
                                          ),
                                          suggestionsCallback: (pattern) {
                                            return provinces
                                                .where((province) => province
                                                    .provinceName
                                                    .toLowerCase()
                                                    .contains(
                                                        pattern.toLowerCase()))
                                                .map((province) =>
                                                    province.provinceName)
                                                .toList();
                                          },
                                          itemBuilder:
                                              (context, String? suggestion) {
                                            return ListTile(
                                              title: Text(suggestion ?? ""),
                                            );
                                          },
                                          onSuggestionSelected:
                                              (String? suggestion) {
                                            setState(() {
                                              province = suggestion;
                                              provinceController.text =
                                                  suggestion ?? "";
                                              updateCities();
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: TypeAheadField<String?>(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            controller: cityController,
                                            decoration: const InputDecoration(
                                              labelText: 'City / Municipality',
                                              border: OutlineInputBorder(),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                            ),
                                          ),
                                          suggestionsCallback: (pattern) {
                                            return cities
                                                .where((city) => city.cityName
                                                    .toLowerCase()
                                                    .contains(
                                                        pattern.toLowerCase()))
                                                .map((city) => city.cityName)
                                                .toList();
                                          },
                                          itemBuilder:
                                              (context, String? suggestion) {
                                            return ListTile(
                                              title: Text(suggestion ?? ""),
                                            );
                                          },
                                          onSuggestionSelected:
                                              (String? suggestion) {
                                            setState(() {
                                              city = suggestion;
                                              selectedCityCode = cities
                                                  .firstWhere((city) =>
                                                      city.cityName ==
                                                      suggestion)
                                                  .cityCode;
                                              cityController.text =
                                                  suggestion ?? "";
                                            });
                                          },
                                        ),
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
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 255, 255),
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
                          ],
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

  Widget buildTextField(String labelText,
      {String hintText = '', double hintFontSize = 14.0}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5), // Set hint text opacity here
            fontSize: hintFontSize, // Set the font size of the hint text
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}

class Region {
  final String regionCode;
  final String regionName;

  Region({required this.regionCode, required this.regionName});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      regionCode: json['region_code'],
      regionName: json['region_name'],
    );
  }
}

class Province {
  final String provinceCode;
  final String provinceName;
  final String regionCode;

  Province({
    required this.provinceCode,
    required this.provinceName,
    required this.regionCode,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      provinceCode: json['province_code'],
      provinceName: json['province_name'],
      regionCode: json['region_code'],
    );
  }
}

class City {
  final String cityCode;
  final String cityName;
  final String provinceCode;

  City({
    required this.cityCode,
    required this.cityName,
    required this.provinceCode,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityCode: json['city_code'],
      cityName: json['city_name'],
      provinceCode: json['province_code'],
    );
  }
}
