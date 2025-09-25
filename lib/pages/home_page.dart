// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'report_incident_page.dart';

class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Call 911
  Future<void> _call911() async {
    final Uri telUri = Uri(scheme: 'tel', path: '911');
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    }
  }

  // Send text alert
  Future<void> _sendTextAlert() async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '911',
      queryParameters: {'body': 'Emergency! Please send help immediately.'},
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    }
  }

  Widget _buildAgencyCard(IconData icon, String label) {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F9), // calm background
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blueGrey[700], size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_outlined, "label": "Home"},
      {"icon": Icons.assignment_outlined, "label": "Reports"},
      {"icon": Icons.chat_bubble_outline, "label": "Messages"},
      {"icon": Icons.settings_outlined, "label": "Settings"},
    ];

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Call & Text bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _call911,
                    icon: const Icon(Icons.call, color: Colors.blue),
                    label: const Text(
                      "Call 911",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _sendTextAlert,
                    icon: const Icon(Icons.message, color: Colors.green),
                    label: const Text(
                      "Text Alert",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Modern nav bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final selected = _currentIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() => _currentIndex = index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.red.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[index]["icon"] as IconData,
                        color: selected ? Colors.red : Colors.grey,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        items[index]["label"] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selected ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            // Greeting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome back,\n${widget.userName}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: const AssetImage(
                      "assets/images/profile.jpg",
                    ),
                    onBackgroundImageError: (_, __) {
                      // Fallback if image fails
                    },
                    backgroundColor: Colors.grey[400],
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Emergency Button with soft radiating pulse
            Expanded(
              flex: 4,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReportIncidentPage(),
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ScaleTransition(
                        scale: Tween(begin: 1.0, end: 1.3).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Color.fromARGB(120, 244, 67, 54),
                                Colors.transparent,
                              ],
                              stops: [0.6, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 170,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 70,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "EMERGENCY",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Tap for Help",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Agencies
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Agencies",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildAgencyCard(Icons.local_hospital, "Ambulance"),
                          _buildAgencyCard(Icons.local_fire_department, "Fire"),
                          _buildAgencyCard(Icons.local_police, "Police"),
                          _buildAgencyCard(Icons.groups, "CDRRMO"),
                          _buildAgencyCard(Icons.more_horiz, "Others"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Recent Reports
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recent Reports",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "View All",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "• Medical Emergency - 2h ago",
                        style: TextStyle(fontSize: 13),
                      ),
                      const Text(
                        "• Traffic Accident - 1d ago",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
