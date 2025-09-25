// lib/responder_home.dart
import 'package:flutter/material.dart';

// Minimal emergency model to pass data to details screen
class Emergency {
  final String type;
  final String location;
  final String timeAgo;
  final String priority;
  final String status;
  final String alertId;
  final int photos;
  final int videos;
  final String distance;
  final String reporterName;
  final String reporterContact;
  final String reporterStatus;
  final String description;
  final String gps;
  final List<Map<String, String>> media; // {name, size, type}
  final List<Map<String, String>> resources; // {name, subtitle, status}

  const Emergency({
    required this.type,
    required this.location,
    required this.timeAgo,
    required this.priority,
    required this.status,
    required this.alertId,
    required this.photos,
    required this.videos,
    required this.distance,
    required this.reporterName,
    required this.reporterContact,
    required this.reporterStatus,
    required this.description,
    required this.gps,
    required this.media,
    required this.resources,
  });
}

class ResponderHome extends StatefulWidget {
  const ResponderHome({super.key});

  @override
  State<ResponderHome> createState() => _ResponderHomeState();
}

class _ResponderHomeState extends State<ResponderHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const EmergencyMapPage(), // Alerts page (list of emergencies)
    const IncidentHistoryPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

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
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.report_outlined),
            selectedIcon: Icon(Icons.report),
            label: "Alerts",
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: "History",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

//
// ---------------- DASHBOARD ----------------
// (unchanged from your original; kept same look/behavior)
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

            // Incoming Reports
            _sectionHeader("Incoming Reports"),
            const SizedBox(height: 12),
            _reportTile(
              "Medical Emergency",
              "Barangay 5 • 8 mins ago",
              Colors.red,
            ),
            _reportTile("Flood Alert", "Barangay 2 • 15 mins ago", Colors.blue),
            _reportTile(
              "Accident on Highway",
              "Barangay 1 • 20 mins ago",
              Colors.orange,
            ),
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
            Text(
              count,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
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
              const Icon(
                Icons.local_fire_department,
                color: Colors.red,
                size: 28,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Fire Incident",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Barangay 3 • 5 mins ago",
                    style: TextStyle(color: Colors.black54),
                  ),
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
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.info, color: Colors.pink),
                  label: const Text(
                    "Details",
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}

//
// ---------------- ALERTS PAGE (replaces map) ----------------
//
class EmergencyMapPage extends StatefulWidget {
  const EmergencyMapPage({super.key});

  @override
  State<EmergencyMapPage> createState() => _EmergencyMapPageState();
}

class _EmergencyMapPageState extends State<EmergencyMapPage> {
  int selectedTab = 0;
  final List<String> tabs = ["All", "Critical", "High", "Medium"];
  final List<int> counts = [12, 2, 5, 5];

  // Sample emergency items (expand as needed)
  final List<Emergency> emergencies = [
    const Emergency(
      type: "Medical Emergency",
      location: "Barangay San Antonio",
      timeAgo: "2 min ago",
      priority: "High",
      status: "Active",
      alertId: "TM-100847",
      photos: 2,
      videos: 1,
      distance: "0.2 km",
      reporterName: "Juan Dela Cruz",
      reporterContact: "+63 917 123 4567",
      reporterStatus: "Conscious & Responsive",
      description:
          "My father suddenly collapsed while walking. He's conscious but having difficulty breathing. Please send medical help immediately. He has a history of heart problems.",
      gps: "14.5547° N, 121.0244° E (±3m accuracy)",
      media: [
        {"name": "scene_photo.jpg", "size": "2.3 MB", "type": "photo"},
        {"name": "situation.mp4", "size": "4.7 MB", "type": "video"},
      ],
      resources: [
        {
          "name": "Pasay General Hospital",
          "subtitle": "12 beds available",
          "status": "hospital",
        },
        {
          "name": "Ambulance Unit 3",
          "subtitle": "Available · 2 min away",
          "status": "ambulance",
        },
        {
          "name": "First Aid Team Alpha",
          "subtitle": "En route · 1 min ETA",
          "status": "team",
        },
      ],
    ),
    Emergency(
      type: "Medical Emergency",
      location: "Barangay San Antonio",
      timeAgo: "3 min ago",
      priority: "High",
      status: "Active",
      alertId: "TM-100848",
      photos: 1,
      videos: 0,
      distance: "0.5 km",
      reporterName: "Ana Santos",
      reporterContact: "+63 912 222 3344",
      reporterStatus: "Unconscious",
      description:
          "Person collapsed, not breathing. Please dispatch ambulance immediately.",
      gps: "14.5548° N, 121.0246° E (±5m accuracy)",
      media: [
        {"name": "photo_scene2.jpg", "size": "1.8 MB", "type": "photo"},
      ],
      resources: [
        {
          "name": "Pasay General Hospital",
          "subtitle": "10 beds available",
          "status": "hospital",
        },
        {
          "name": "Ambulance Unit 5",
          "subtitle": "Busy · 5 min away",
          "status": "ambulance",
        },
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Blue header
          Container(
            width: double.infinity,
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: const Center(
              child: Text(
                "All Emergencies",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Tabs row
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabs.length, (index) {
                final bool isSelected = selectedTab == index;
                return GestureDetector(
                  onTap: () => setState(() => selectedTab = index),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade50
                              : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          "${tabs[index]} (${counts[index]})",
                          style: TextStyle(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade800,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          height: 3,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),

          // Emergency list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: emergencies.length,
              itemBuilder: (context, index) {
                final e = emergencies[index];
                return GestureDetector(
                  onTap: () => _openDetails(context, e),
                  child: _emergencyCard(e),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _emergencyCard(Emergency e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.favorite, color: Colors.red, size: 26),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.type,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            e.location,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Reported ${e.timeAgo}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _badge(
                    e.priority,
                    Colors.amber.shade100,
                    Colors.orange.shade800,
                  ),
                  const SizedBox(height: 8),
                  _badge(e.status, Colors.pink.shade100, Colors.pink.shade700),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),
          Text("Alert ID: ${e.alertId}", style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Row(
            children: [
              _smallInfoChip(Icons.photo_camera, "${e.photos} photos"),
              const SizedBox(width: 8),
              _smallInfoChip(Icons.videocam, "${e.videos} video"),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _respondAction(e),
                  icon: const Icon(Icons.send, size: 18),
                  label: const Text("Respond"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _openDetails(context, e),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "View Details",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Distance: ${e.distance}",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _openDetails(BuildContext context, Emergency e) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => EmergencyDetailsPage(e)));
  }

  void _respondAction(Emergency e) {
    // Placeholder for respond flow
    // Keep minimal: show a snackbar
    // In production: navigate to accept flow or mark accepted
    // (Why) quick feedback to user
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(
        navigatorKey.currentContext ?? navigatorKey.currentContext!,
      ).showSnackBar(SnackBar(content: Text('Responding to ${e.alertId}')));
    });
  }
}

// A GlobalKey to support snackbars from non-widget contexts (used in respond placeholder)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Widget _badge(String text, Color bg, Color textColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _smallInfoChip(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade700),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey.shade800, fontSize: 13)),
      ],
    ),
  );
}

//
// ---------------- EMERGENCY DETAILS ----------------
//
class EmergencyDetailsPage extends StatelessWidget {
  final Emergency emergency;

  const EmergencyDetailsPage(this.emergency, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerColor = Colors.red.shade700;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerColor,
        title: const Text('Emergency Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Top summary card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade100),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        emergency.type,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Alert ID: ${emergency.alertId}",
                        style: TextStyle(color: Colors.red.shade900),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${emergency.priority} Priority',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Reported ${emergency.timeAgo}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Location card
          _infoCard(
            icon: Icons.place,
            title: 'Location',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  emergency.location,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  'GPS: ${emergency.gps}',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.place, size: 28, color: Colors.grey),
                        SizedBox(height: 6),
                        Text(
                          'Interactive Map',
                          style: TextStyle(color: Colors.black54),
                        ),
                        Text(
                          'Showing exact location & route',
                          style: TextStyle(color: Colors.black38, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Reporter information
          _infoCard(
            icon: Icons.person,
            title: 'Reporter Information',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kvRow('Name:', emergency.reporterName),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Call ${emergency.reporterContact}'),
                    ),
                  ),
                  child: _kvRow(
                    'Contact:',
                    emergency.reporterContact,
                    valueStyle: const TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 6),
                _kvRow(
                  'Status:',
                  emergency.reporterStatus,
                  valueStyle: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Description
          _infoCard(
            icon: Icons.description,
            title: 'Description',
            child: Text(emergency.description),
          ),

          const SizedBox(height: 12),

          // Media attachments
          _infoCard(
            icon: Icons.photo,
            title: 'Media Attachments',
            child: Column(
              children: [
                Row(
                  children: emergency.media.map((m) {
                    final isVideo = m['type'] == 'video';
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isVideo ? Icons.videocam : Icons.photo,
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                m['name'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              m['size'] ?? '',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('View Photos')),
                            ),
                        child: const Text('View Photos'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Play Video')),
                            ),
                        child: const Text('Play Video'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Available resources
          _infoCard(
            icon: Icons.local_shipping,
            title: 'Available Resources',
            child: Column(
              children: emergency.resources.map((r) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        r['status'] == 'hospital'
                            ? Icons.local_hospital
                            : (r['status'] == 'ambulance'
                                  ? Icons.local_shipping
                                  : Icons.people),
                        color: Colors.grey.shade800,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          r['name'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        r['subtitle'] ?? '',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // Primary action
          ElevatedButton.icon(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Accepted & Responding')),
            ),
            icon: const Icon(Icons.send),
            label: const Text('Accept & Respond'),
            style: ElevatedButton.styleFrom(
              backgroundColor: headerColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Secondary actions row
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Calling reporter...')),
                  ),
                  icon: const Icon(Icons.call),
                  label: const Text('Call Reporter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening message composer...'),
                    ),
                  ),
                  icon: const Icon(Icons.message),
                  label: const Text('Send Message'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Requesting additional resources...'),
              ),
            ),
            child: const Text('Request Additional Resources'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Forwarding to another unit...')),
            ),
            child: const Text('Forward to Another Unit'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // Small utility for key-value rows
  static Widget _kvRow(String key, String value, {TextStyle? valueStyle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(key, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        Expanded(child: Text(value, style: valueStyle ?? const TextStyle())),
      ],
    );
  }
}

// Info card helper
Widget _infoCard({
  required IconData icon,
  required String title,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
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
        const Text(
          "Incident History",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _historyTile("Fire Incident", "Resolved • Sept 12, 2025", Colors.green),
        _historyTile(
          "Medical Emergency",
          "Resolved • Sept 10, 2025",
          Colors.green,
        ),
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
        const Text(
          "Responder Name",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        const Text(
          "Emergency Responder",
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
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
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
