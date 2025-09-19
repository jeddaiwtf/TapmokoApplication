import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/contact.dart';

class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      Contact(name: "Fire Department", phone: "123-4567"),
      Contact(name: "Police", phone: "911"),
      Contact(name: "Hospital", phone: "789-0000"),
    ];

    IconData getIcon(String name) {
      if (name.contains("Fire")) return Icons.local_fire_department_rounded;
      if (name.contains("Police")) return Icons.local_police_rounded;
      if (name.contains("Hospital")) return Icons.local_hospital_rounded;
      return Icons.contact_phone_rounded;
    }

    Color getColor(String name) {
      if (name.contains("Fire")) return Colors.redAccent;
      if (name.contains("Police")) return Colors.blueAccent;
      if (name.contains("Hospital")) return Colors.green;
      return Colors.amber;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.12),
            Theme.of(context).colorScheme.secondary.withOpacity(0.08),
            Theme.of(context).colorScheme.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        itemCount: contacts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Card(
                elevation: 8,
                color: Colors.white.withOpacity(0.65),
                shadowColor: getColor(contact.name).withOpacity(0.18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: getColor(contact.name).withOpacity(0.18),
                    radius: 30,
                    child: Icon(
                      getIcon(contact.name),
                      color: getColor(contact.name),
                      size: 32,
                    ),
                  ),
                  title: Text(
                    contact.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                  subtitle: Text(
                    contact.phone,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  trailing: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1, end: 1),
                    duration: const Duration(milliseconds: 200),
                    builder: (context, scale, child) => Transform.scale(
                      scale: scale,
                      child: child,
                    ),
                    child: FilledButton.icon(
                      icon: const Icon(Icons.call),
                      label: const Text("Call"),
                      style: FilledButton.styleFrom(
                        backgroundColor: getColor(contact.name),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                        elevation: 2,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Calling ${contact.name}...")),
                        );
                      },
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 22,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
