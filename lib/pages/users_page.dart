import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _roleFilter = "All";

  List<Map<String, String>> users = [
    {"id": "1", "name": "Alice", "email": "alice@mail.com", "role": "Admin"},
    {"id": "2", "name": "Bob", "email": "bob@mail.com", "role": "User"},
    {"id": "3", "name": "Charlie", "email": "charlie@mail.com", "role": "User"},
    {
      "id": "4",
      "name": "David",
      "email": "david@mail.com",
      "role": "Moderator"
    },
    {"id": "5", "name": "Eve", "email": "eve@mail.com", "role": "User"},
  ];

  void _addUserDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    String role = "User";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name")),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email")),
            DropdownButtonFormField<String>(
              value: role,
              items: const [
                DropdownMenuItem(value: "Admin", child: Text("Admin")),
                DropdownMenuItem(value: "User", child: Text("User")),
                DropdownMenuItem(value: "Moderator", child: Text("Moderator")),
              ],
              onChanged: (val) => role = val!,
              decoration: const InputDecoration(labelText: "Role"),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                users.add({
                  "id": (users.length + 1).toString(),
                  "name": nameController.text,
                  "email": emailController.text,
                  "role": role,
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _editUserDialog(Map<String, String> user) {
    final nameController = TextEditingController(text: user["name"]);
    final emailController = TextEditingController(text: user["email"]);
    String role = user["role"] ?? "User";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name")),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email")),
            DropdownButtonFormField<String>(
              value: role,
              items: const [
                DropdownMenuItem(value: "Admin", child: Text("Admin")),
                DropdownMenuItem(value: "User", child: Text("User")),
                DropdownMenuItem(value: "Moderator", child: Text("Moderator")),
              ],
              onChanged: (val) => role = val!,
              decoration: const InputDecoration(labelText: "Role"),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                user["name"] = nameController.text;
                user["email"] = emailController.text;
                user["role"] = role;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _deleteUser(Map<String, String> user) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete ${user["name"]}?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                users.remove(user);
              });
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users.where((u) {
      final matchesSearch = u["name"]!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          u["email"]!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      final matchesRole = _roleFilter == "All" || u["role"] == _roleFilter;
      return matchesSearch && matchesRole;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Add Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Manage Users",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _addUserDialog,
                icon: const Icon(Icons.add),
                label: const Text("Add User"),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Filters
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search users...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: _roleFilter,
                items: const [
                  DropdownMenuItem(value: "All", child: Text("All Roles")),
                  DropdownMenuItem(value: "Admin", child: Text("Admin")),
                  DropdownMenuItem(value: "User", child: Text("User")),
                  DropdownMenuItem(
                      value: "Moderator", child: Text("Moderator")),
                ],
                onChanged: (val) => setState(() => _roleFilter = val!),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Users Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Role")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: filteredUsers.map((user) {
                  return DataRow(cells: [
                    DataCell(Text(user["id"]!)),
                    DataCell(Text(user["name"]!)),
                    DataCell(Text(user["email"]!)),
                    DataCell(Text(user["role"]!)),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editUserDialog(user),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteUser(user),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
