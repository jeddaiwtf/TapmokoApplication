import 'package:flutter/material.dart';

class IncidentDetailsPage extends StatefulWidget {
  final Map<String, dynamic>? report;

  const IncidentDetailsPage({super.key, this.report});

  @override
  State<IncidentDetailsPage> createState() => _IncidentDetailsPageState();
}

class _IncidentDetailsPageState extends State<IncidentDetailsPage> {
  late String status;
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    status = widget.report?["status"] ?? "Pending";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final report = widget.report ??
        {
          "title": "Unknown Incident",
          "description": "No details available.",
          "status": "Pending",
          "date": "N/A"
        };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Incident Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // Title
            Text(
              report["title"],
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Date
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: theme.hintColor),
                const SizedBox(width: 6),
                Text(
                  report["date"],
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Description
            Text(
              report["description"],
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Current Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status:",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _statusColor(status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _statusColor(status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Update Status Dropdown
            DropdownButtonFormField<String>(
              initialValue: status,
              items: ["Pending", "In Progress", "Resolved"]
                  .map(
                    (s) => DropdownMenuItem(
                      value: s,
                      child: Text(s),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    status = val;
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: "Update Status",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Notes / Remarks
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Add Notes / Remarks",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Save Button
            ElevatedButton.icon(
              onPressed: () {
                // Later: save to Firestore
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Updated: Status=$status, Notes=${notesController.text}"),
                  ),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text("Save Updates"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "In Progress":
        return Colors.blue;
      case "Resolved":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
