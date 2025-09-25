// lib/pages/report_incident_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class ReportIncidentPage extends StatefulWidget {
  const ReportIncidentPage({super.key});

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  final TextEditingController _descController = TextEditingController();
  File? _selectedMedia;
  String? _location;
  bool _isSubmitting = false;
  String? _selectedType;

  final List<Map<String, dynamic>> emergencyTypes = [
    {"label": "Medical", "icon": Icons.favorite, "color": Colors.red},
    {"label": "Fire", "icon": Icons.warning, "color": Colors.orange},
    {"label": "Accident", "icon": Icons.directions_car, "color": Colors.amber},
    {"label": "Crime", "icon": Icons.shield, "color": Colors.purple},
    {"label": "Natural", "icon": Icons.show_chart, "color": Colors.blue},
    {"label": "Other", "icon": Icons.error_outline, "color": Colors.grey},
  ];

  Future<void> _pickMedia(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 75);
    if (pickedFile != null) {
      setState(() => _selectedMedia = File(pickedFile.path));
    }
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permanently denied.")),
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() => _location = "${position.latitude}, ${position.longitude}");
  }

  void _submitReport() async {
    if (_selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an emergency type")),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSubmitting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Report submitted successfully!")),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildTypeTile(
    Map<String, dynamic> type,
    double width,
    double height,
  ) {
    final isSelected = _selectedType == type["label"];
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type["label"]),
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? (type["color"] as Color).withOpacity(0.10)
                : const Color(0xFFF1F4F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? (type["color"] as Color)
                  : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(type["icon"], size: 30, color: type["color"]),
              const SizedBox(height: 8),
              Text(
                type["label"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 10.0;
    const crossCount = 3;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Report Emergency",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Emergency types
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Emergency Type",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth;
                  final itemWidth =
                      (totalWidth - (crossCount - 1) * spacing) / crossCount;
                  final itemHeight = itemWidth * 0.92;
                  final gridHeight = itemHeight * 2 + spacing;

                  return SizedBox(
                    height: gridHeight,
                    child: Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: emergencyTypes
                          .map((t) => _buildTypeTile(t, itemWidth, itemHeight))
                          .toList(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),

              // Description
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description (Optional)",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 96,
                child: TextField(
                  controller: _descController,
                  minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Briefly describe the emergency situation...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F4F9),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Media
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickMedia(ImageSource.camera),
                      icon: const Icon(Icons.photo_camera, color: Colors.blue),
                      label: const Text(
                        "Photo",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickMedia(ImageSource.gallery),
                      icon: const Icon(
                        Icons.video_library,
                        color: Colors.green,
                      ),
                      label: const Text(
                        "Video",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              if (_selectedMedia != null) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedMedia!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],

              const SizedBox(height: 12),

              // Location
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  leading: const Icon(Icons.location_on, color: Colors.red),
                  title: const Text("Current Location"),
                  subtitle: Text(
                    _location ?? "Location not captured",
                    style: TextStyle(
                      color: _location == null ? Colors.grey : Colors.black87,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: _getLocation,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Expand + Submit button to fill bottom
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitReport,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 22,
                          ), // bigger height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "SEND REPORT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
