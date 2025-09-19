import 'package:flutter/material.dart';

class MyReportsPage extends StatelessWidget {
  const MyReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock Data (replace with Firestore later)
    final List<Map<String, String>> reports = [
      {
        "title": "Fire at Barangay Hall",
        "description": "A small fire started in the storage room.",
        "status": "Pending",
        "date": "Sept 10, 2025",
      },
      {
        "title": "Flooding on Main Street",
        "description": "Water rising near the marketplace.",
        "status": "In Progress",
        "date": "Sept 9, 2025",
      },
      {
        "title": "Road Accident",
        "description": "Two vehicles collided near the bridge.",
        "status": "Resolved",
        "date": "Sept 5, 2025",
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("My Reports"), centerTitle: true),
      body: reports.isEmpty
          ? const Center(
              child: Text(
                "No reports yet.\nSubmit an incident to get started.",
                textAlign: TextAlign.center,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: reports.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final report = reports[index];
                return _ReportCard(
                  title: report["title"] ?? "Untitled",
                  description: report["description"] ?? "No description",
                  status: report["status"] ?? "Unknown",
                  date: report["date"] ?? "",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/incident_details',
                      arguments: report,
                    );
                  },
                );
              },
            ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final String date;
  final VoidCallback onTap;

  const _ReportCard({
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.onTap,
  });

  Color _statusColor(BuildContext context) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "In Progress":
        return Colors.blue;
      case "Resolved":
        return Colors.green;
      default:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(context).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _statusColor(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),

            // Date
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: theme.colorScheme.outline,
                ),
                const SizedBox(width: 6),
                Text(
                  date,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
