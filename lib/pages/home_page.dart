// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:intl/intl.dart'; // make sure intl: ^0.19.0 is in pubspec.yaml

class HomePage extends StatefulWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomeScreen(userName: widget.userName),
      const _ReportsScreen(),
      const _ContactsScreen(),
      const _MessagingScreen(),
      _SettingsScreen(onSignOut: _signOut),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

//
// HOME SCREEN
//
class _HomeScreen extends StatelessWidget {
  final String userName;
  const _HomeScreen({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome back,",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=47",
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),
        const Text(
          "Having an Emergency?",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "Press the button below\nhelp will arrive soon.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 40),

        // Emergency Button
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("🚨 Calling Emergency...")),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(0.1),
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(0.2),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.redAccent],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent,
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.call,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // New Emergency Report Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.report, color: Colors.white),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EmergencyReportPage(userName: userName),
                ),
              );
            },
            label: const Text(
              "Send Emergency Report",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

//
// EMERGENCY REPORT PAGE
//
class EmergencyReportPage extends StatefulWidget {
  final String userName;
  const EmergencyReportPage({super.key, required this.userName});

  @override
  State<EmergencyReportPage> createState() => _EmergencyReportPageState();
}

class _EmergencyReportPageState extends State<EmergencyReportPage> {
  final _formKey = GlobalKey<FormState>();
  String? _emergencyType;
  String? _severity;
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final incidentTime = DateFormat(
      "yyyy-MM-dd HH:mm:ss",
    ).format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Report"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Location (GPS): [Lat, Long]",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              const Text(
                "Address: (Auto fetched here)",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Indoor Details (room, floor, building)",
                ),
              ),

              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Type of Emergency",
                ),
                items:
                    ["Fire", "Medical", "Accident", "Crime", "Natural Disaster"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) => setState(() => _emergencyType = val),
                validator: (val) =>
                    val == null ? "Please select emergency type" : null,
              ),

              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Severity/Urgency",
                ),
                items: ["Low", "Medium", "High", "Critical"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _severity = val),
                validator: (val) =>
                    val == null ? "Please select severity" : null,
              ),

              const SizedBox(height: 20),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Description"),
              ),

              const SizedBox(height: 20),
              const Text(
                "Photo/Video Evidence (optional)",
                style: TextStyle(color: Colors.black54),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.attach_file),
                label: const Text("Upload File"),
              ),

              const SizedBox(height: 20),
              Text("Time of Incident: $incidentTime"),
              Text("Reporter: ${widget.userName}"),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint("Emergency Type: $_emergencyType");
                    debugPrint("Severity: $_severity");
                    debugPrint("Description: ${_descController.text}");
                    debugPrint("Time: $incidentTime");
                    debugPrint("Reporter: ${widget.userName}");

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("✅ Emergency report submitted"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  "Submit Report",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// REPORTS SCREEN (placeholder)
//
class _ReportsScreen extends StatelessWidget {
  const _ReportsScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Reports Page"));
  }
}

//
// CONTACTS SCREEN
//
class _ContactsScreen extends StatelessWidget {
  const _ContactsScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Contacts Page"));
  }
}

//
// MESSAGING SCREEN
//
class _MessagingScreen extends StatelessWidget {
  const _MessagingScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Messaging Page"));
  }
}

//
// SETTINGS SCREEN
//
class _SettingsScreen extends StatelessWidget {
  final VoidCallback onSignOut;
  const _SettingsScreen({required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Settings Page"));
  }
}
