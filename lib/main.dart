// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

// Import Pages
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/report_incident_page.dart';
import 'pages/my_reports_page.dart';
import 'pages/incident_details_page.dart';
import 'pages/emergency_contacts_page.dart';
import 'pages/admin_dashboard_page.dart';
import 'pages/responder_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TapMokoApp());
}

class TapMokoApp extends StatelessWidget {
  const TapMokoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'TapMoko',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue.shade800,
              brightness: Brightness.light,
            ),
            textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          ),
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginPage(),

            // ⚠️ HomePage requires userName, so don’t add it here directly.
            // Navigate with:
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (_) => HomePage(userName: "User")),
            // );
            '/report_incident': (context) => const ReportIncidentPage(),
            '/my_reports': (context) => const MyReportsPage(),
            '/incident_details': (context) => const IncidentDetailsPage(),
            '/emergency_contacts': (context) => const EmergencyContactsPage(),
            '/admin': (context) => const AdminDashboardPage(),
            '/responder_home': (context) => const ResponderHome(),
          },
        );
      },
    );
  }
}
