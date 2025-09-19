import 'package:flutter/material.dart';

class ResponderHome extends StatefulWidget {
  const ResponderHome({super.key});

  @override
  State<ResponderHome> createState() => _ResponderHomeState();
}

class _ResponderHomeState extends State<ResponderHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const EmergencyMapPage(),
    const IncidentHistoryPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        indicatorColor: Colors.pink.shade100,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: "Dashboard"),
          NavigationDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map),
              label: "Map"),
          NavigationDestination(
              icon: Icon(Icons.history_outlined),
              selectedIcon: Icon(Icons.history),
              label: "History"),
          NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: "Profile"),
        ],
      ),
    );
  }
}

//
// ---------------- DASHBOARD ----------------
//
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting + notification
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Responder Dashboard",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.pink.shade100,
                  child: const Icon(Icons.notifications, color: Colors.pink),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats Row
            Row(
              children: [
                _statCard("Active", "2", Colors.orange.shade400),
                const SizedBox(width: 12),
                _statCard("Completed", "15", Colors.green.shade400),
                const SizedBox(width: 12),
                _statCard("Pending", "3", Colors.red.shade400),
              ],
            ),
            const SizedBox(height: 24),

            // Active Incident Section
            _sectionHeader("Active Incident"),
            _activeIncidentCard(context),
            const SizedBox(height: 24),

            // Quick Actions Section
            _sectionHeader("Quick Actions"),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _actionButton(Icons.phone_in_talk, "Call Admin", Colors.green),
                _actionButton(
                    Icons.chat_bubble_outline, "Message", Colors.blue),
                _actionButton(Icons.warning_amber, "Alerts", Colors.orange),
              ],
            ),
            const SizedBox(height: 24),

            // Incoming Reports
            _sectionHeader("Incoming Reports"),
            const SizedBox(height: 12),
            _reportTile(
                "Medical Emergency", "Barangay 5 • 8 mins ago", Colors.red),
            _reportTile("Flood Alert", "Barangay 2 • 15 mins ago", Colors.blue),
            _reportTile("Accident on Highway", "Barangay 1 • 20 mins ago",
                Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _statCard(String label, String count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(count,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _activeIncidentCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_fire_department,
                  color: Colors.red, size: 28),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Fire Incident",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Barangay 3 • 5 mins ago",
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text("Accept"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.pink),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.info, color: Colors.pink),
                  label: const Text("Details",
                      style: TextStyle(color: Colors.pink)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _reportTile(String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(Icons.report_outlined, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}

//
// ---------------- MAP PAGE ----------------
//
class EmergencyMapPage extends StatelessWidget {
  const EmergencyMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("🗺 Map Placeholder (Google Maps here)",
          style: TextStyle(fontSize: 16)),
    );
  }
}

//
// ---------------- HISTORY PAGE ----------------
//
class IncidentHistoryPage extends StatelessWidget {
  const IncidentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("Incident History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _historyTile("Fire Incident", "Resolved • Sept 12, 2025", Colors.green),
        _historyTile(
            "Medical Emergency", "Resolved • Sept 10, 2025", Colors.green),
        _historyTile("Flood Alert", "Pending • Sept 9, 2025", Colors.orange),
      ],
    );
  }

  Widget _historyTile(String title, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(Icons.assignment_turned_in, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status),
      ),
    );
  }
}

//
// ---------------- PROFILE PAGE ----------------
//
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(
          radius: 45,
          backgroundColor: Colors.pink,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 12),
        const Text("Responder Name",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        const SizedBox(height: 4),
        const Text("Emergency Responder",
            style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
        const SizedBox(height: 24),
        _profileTile(Icons.settings, "Settings", Colors.pink),
        _profileTile(Icons.help_outline, "Help & Support", Colors.blueGrey),
        _profileTile(Icons.logout, "Logout", Colors.red),
      ],
    );
  }

  Widget _profileTile(IconData icon, String title, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}
