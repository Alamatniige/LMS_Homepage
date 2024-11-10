import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading assets
import 'package:lms_homepage/archive_class.dart';
import 'package:lms_homepage/login_page.dart';
import 'package:lms_homepage/main.dart';
import 'package:lms_homepage/upload_grade.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isSidebarExpanded = false;
  bool isHovering = false;

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
