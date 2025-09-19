// lib/models/report.dart

class Report {
  final String id;
  final String type; // "Fire", "Medical", "Other", etc.
  final String status; // "Pending", "Dispatched", "Resolved"
  final DateTime timestamp;
  final String description; // user-provided description
  final String? photoPath; // local path or remote URL (nullable)
  final String? location; // e.g., "14.5995,120.9842" (nullable)

  Report({
    required this.id,
    required this.type,
    required this.status,
    required this.timestamp,
    this.description = '',
    this.photoPath,
    this.location,
  });
}
