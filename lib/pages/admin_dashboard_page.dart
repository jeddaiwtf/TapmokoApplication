import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardOverviewPage(),
    const ReportsPage(),
    const UsersPage(),
    const MessagesPage(),
    const SettingsPage(),
    const ProfilePage(),
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {"icon": Icons.dashboard, "label": "Dashboard"},
    {"icon": Icons.assignment, "label": "Reports"},
    {"icon": Icons.people, "label": "Users"},
    {"icon": Icons.message, "label": "Messages"},
    {"icon": Icons.settings, "label": "Settings"},
    {"icon": Icons.person, "label": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // 💻 Desktop / Tablet
          return Row(
            children: [
              _buildSidebar(),
              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  child: _pages[_selectedIndex],
                ),
              ),
            ],
          );
        } else {
          // 📱 Mobile
          return Scaffold(
            appBar: AppBar(
              title: Text(_menuItems[_selectedIndex]["label"]),
              backgroundColor: Colors.blue.shade800,
            ),
            drawer: Drawer(child: _buildSidebar(isDrawer: true)),
            body: _pages[_selectedIndex],
          );
        }
      },
    );
  }

  Widget _buildSidebar({bool isDrawer = false}) {
    return Container(
      width: isDrawer ? null : 220,
      color: Colors.blue.shade800,
      child: Column(
        children: [
          Container(
            height: 80,
            alignment: Alignment.center,
            child: const Text(
              "Admin Panel",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedIndex == index;
                return ListTile(
                  leading: Icon(_menuItems[index]["icon"], color: Colors.white),
                  title: Text(
                    _menuItems[index]["label"],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  tileColor: isSelected ? Colors.blue.shade600 : null,
                  onTap: () {
                    setState(() => _selectedIndex = index);
                    if (isDrawer) Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//
// Dashboard Overview Page
//
class DashboardOverviewPage extends StatelessWidget {
  const DashboardOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dashboard",
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // ✅ Responsive stats cards
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildStatCard("152", "Total Reports", Colors.blue),
              _buildStatCard("87", "Resolved", Colors.green),
              _buildStatCard("42", "Pending", Colors.orange),
              _buildStatCard("1,024", "Users", Colors.purple),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Reports",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    // ✅ Make DataTable scrollable on mobile
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text("ID")),
                          DataColumn(label: Text("Title")),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("Date")),
                        ],
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(Text("1")),
                              DataCell(Text("Fire in Building")),
                              DataCell(Text("Open")),
                              DataCell(Text("2023-09-01")),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text("2")),
                              DataCell(Text("Road Accident")),
                              DataCell(Text("Resolved")),
                              DataCell(Text("2023-09-02")),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text("3")),
                              DataCell(Text("Flooding Report")),
                              DataCell(Text("Pending")),
                              DataCell(Text("2023-09-03")),
                            ],
                          ),
                        ],
                      ),
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

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

//
// Reports Page
//
class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildTablePage(
      "Manage Reports",
      [
        ["1", "Fire in Building", "Open", "2023-09-01"],
        ["2", "Road Accident", "Resolved", "2023-09-02"],
        ["3", "Flooding", "Pending", "2023-09-03"],
      ],
      ["ID", "Title", "Status", "Date"],
    );
  }
}

//
// Users Page
//
class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildTablePage(
      "Manage Users",
      [
        ["1", "Alice", "alice@mail.com", "Admin"],
        ["2", "Bob", "bob@mail.com", "User"],
        ["3", "Charlie", "charlie@mail.com", "User"],
        ["4", "David", "david@mail.com", "Moderator"],
      ],
      ["ID", "Name", "Email", "Role"],
    );
  }
}

//
// Messages Page
//
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  int _selectedChat = 0;

  final List<Map<String, dynamic>> chats = [
    {
      "name": "Luy Robin",
      "initials": "LR",
      "lastMessage": "Can I get help...?",
      "messages": [
        {"fromMe": false, "text": "Hello! I need help."},
        {"fromMe": true, "text": "Sure, what’s the issue?"},
      ],
    },
    {
      "name": "Mark Malik",
      "initials": "MM",
      "lastMessage": "Thank you very much!",
      "messages": [
        {"fromMe": false, "text": "Thanks for your help!"},
        {"fromMe": true, "text": "Glad I could assist."},
      ],
    },
  ];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      chats[_selectedChat]["messages"].add({
        "fromMe": true,
        "text": _messageController.text.trim(),
      });
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final currentChat = chats[_selectedChat];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          // 💻 Desktop - show chat list + messages
          return Row(
            children: [
              _buildChatList(),
              Container(width: 1, color: Colors.grey.shade300),
              Expanded(child: _buildChatArea(currentChat)),
            ],
          );
        } else {
          // 📱 Mobile - only show chat area
          return _buildChatArea(currentChat);
        }
      },
    );
  }

  Widget _buildChatList() {
    return Container(
      width: 300,
      color: Colors.white,
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          final isSelected = _selectedChat == index;
          return ListTile(
            leading: CircleAvatar(child: Text(chat["initials"])),
            title: Text(
              chat["name"],
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(
              chat["lastMessage"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            tileColor: isSelected ? Colors.blue.shade50 : null,
            onTap: () => setState(() => _selectedChat = index),
          );
        },
      ),
    );
  }

  Widget _buildChatArea(Map<String, dynamic> currentChat) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(child: Text(currentChat["initials"])),
              const SizedBox(width: 12),
              Text(
                currentChat["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              IconButton(icon: const Icon(Icons.call), onPressed: () {}),
              IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: currentChat["messages"].length,
            itemBuilder: (context, index) {
              final msg = currentChat["messages"][index];
              final isMe = msg["fromMe"] as bool;
              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue.shade100 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(msg["text"]),
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: "Type a message...",
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send, color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//
// Settings Page
//
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          "Settings",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        SwitchListTile(
          title: const Text("Enable Notifications"),
          value: true,
          onChanged: (_) {},
        ),
        SwitchListTile(
          title: const Text("Dark Mode"),
          value: false,
          onChanged: (_) {},
        ),
      ],
    );
  }
}

//
// Profile Page
//
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Admin Profile",
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(decoration: const InputDecoration(labelText: "Name")),
          TextField(decoration: const InputDecoration(labelText: "Email")),
          TextField(decoration: const InputDecoration(labelText: "Password")),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: () {}, child: const Text("Save Changes")),
        ],
      ),
    );
  }
}

//
// Helper for Table Pages
//
Widget _buildTablePage(
  String title,
  List<List<String>> rows,
  List<String> headers,
) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.blue.shade50),
                columns: headers
                    .map((h) => DataColumn(label: Text(h)))
                    .toList(),
                rows: rows
                    .map(
                      (r) => DataRow(
                        cells: r.map((c) => DataCell(Text(c))).toList(),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
