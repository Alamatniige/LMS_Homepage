import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.green,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> notes = [];

  void _addNote() {
    TextEditingController noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter your note"),
          content: TextField(
            controller: noteController,
            decoration: InputDecoration(hintText: "Note text"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Add Note"),
              onPressed: () {
                setState(() {
                  notes.add({'text': noteController.text, 'completed': false});
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleDone(int index) {
    setState(() {
      notes[index]['completed'] = !notes[index]['completed'];
    });
  }

  void _removeNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Section
            Header(),

            SizedBox(height: 20),

            // Main Content Section
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sidebar Section
                  Sidebar(
                    onAddNote: _addNote,
                    notes: notes,
                    toggleDone: _toggleDone,
                    removeNote: _removeNote,
                  ),

                  SizedBox(width: 20),

                  // Class Container Section
                  Expanded(
                    child: ClassContainer(),
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

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
      ),
      child: Column(
        // Changed Row to Column to stack the logo and text
        mainAxisAlignment: MainAxisAlignment.center, // Center vertically
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
            children: [
              Image.asset(
                'assets/plsp.png',
                width: 90,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to start
                children: [
                  Text(
                    'Pamantasan ng Lungsod ng San Pablo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Brgy. San Jose, San Pablo City',
                      style: TextStyle(fontSize: 12)),
                  Text('Tel No: (049) 536-7830',
                      style: TextStyle(fontSize: 12)),
                  Text('Email Address: plspofficial@plsp.edu.ph',
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  final Function onAddNote;
  final List<Map<String, dynamic>> notes;
  final Function(int) toggleDone;
  final Function(int) removeNote;

  Sidebar(
      {required this.onAddNote,
      required this.notes,
      required this.toggleDone,
      required this.removeNote});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Profile Section
          Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/profile.png'),
                radius: 35,
              ),
              SizedBox(height: 10),
              Text('Happy Monday, Ms. Alice!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 20),

          // Menu Section
          Column(
            children: [
              MenuButton('Add Students'),
              MenuButton('Rating Sheets'),
              MenuButton('Upload Grades'),
              MenuButton('Logout'),
            ],
          ),
          SizedBox(height: 20),

          // Notes Section
          NotesSection(
            onAddNote: onAddNote,
            notes: notes,
            toggleDone: toggleDone,
            removeNote: removeNote,
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String text;
  final Color buttonColor; // Color for the button background
  final Color textColor; // Color for the button text

  MenuButton(this.text,
      {this.buttonColor =
          const Color.fromARGB(255, 73, 155, 76), // Default button color
      this.textColor = Colors.white}); // Default text color

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity, // Make the button fill the available width
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor, // Set the button background color
            padding: EdgeInsets.symmetric(vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          onPressed: () {
            // Define your button action here
          },
          child: Text(
            text,
            style: TextStyle(color: textColor), // Set the text color
          ),
        ),
      ),
    );
  }
}

class NotesSection extends StatelessWidget {
  final Function onAddNote;
  final List<Map<String, dynamic>> notes;
  final Function(int) toggleDone;
  final Function(int) removeNote;

  NotesSection({
    required this.onAddNote,
    required this.notes,
    required this.toggleDone,
    required this.removeNote,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Notes', style: TextStyle(fontSize: 22)),
        Container(
          height: 200, // Set a fixed height for the notes section
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  notes[index]['text'],
                  style: TextStyle(
                    decoration: notes[index]['completed']
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () => toggleDone(index),
                      color: notes[index]['completed']
                          ? Colors.green
                          : Colors.grey,
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => removeNote(index),
                      color: Colors.red,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => onAddNote(),
          child: Text("Add Note"),
        ),
      ],
    );
  }
}

class ClassContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Classes',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10), // Reduced spacing between title and grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 3, // Adjust this value for the number of columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio:
                  1.5, // Adjusts the aspect ratio for height vs width
              children: [
                ClassCard(
                  title: 'College of Computer Studies and Technology',
                  description:
                      'CC214 - Data Structure and Algorithm\nBSIT - 2C\nRoom 203',
                ),
                ClassCard(
                  title: 'College of Computer Studies and Technology',
                  description:
                      'CC214 - Data Structure and Algorithm\nBSIT - 2A\nRoom 211',
                ),
                ClassCard(
                  title: 'College of Computer Studies and Technology',
                  description:
                      'CC111 - Introduction to Computing\nBSIT - 1D\nRoom 207',
                ),
                ClassCard(
                  title: 'College of Computer Studies and Technology',
                  description:
                      'ITProfE13 - Project Management\nBSIT - 3D\nRoom 203',
                ),
                ClassCard(
                  title: 'College of Computer Studies and Technology',
                  description: 'LITE - Living in IT Era\nBSIT - 1A\nRoom 210',
                ),
                AddClassCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClassCard extends StatefulWidget {
  final String title;
  final String description;

  ClassCard({required this.title, required this.description});

  @override
  _ClassCardState createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        height: 100, // Set a fixed height for a shorter, rectangular shape
        decoration: BoxDecoration(
          color: _isHovered ? Colors.green[50] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: _isHovered ? Colors.green[300]! : Colors.black12,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Expanded(
              // Use Expanded to allow for flexible height
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis, // Prevent overflow
                maxLines: 2, // Limit the number of lines
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {},
                child: Text('View Class'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddClassCard extends StatefulWidget {
  @override
  _AddClassCardState createState() => _AddClassCardState();
}

class _AddClassCardState extends State<AddClassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _isHovered
              ? Colors.green.shade100
              : Colors.white, // Change background color on hover
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, _isHovered ? 4 : 2), // Adjust shadow on hover
            ),
          ],
        ),
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 50, color: Colors.green),
              Text('Add Class', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
