import 'package:apexcify_technologys_profile_page/profile_page_core.dart';

void main() {
  runApp(const ApexcifyApp());
}

class ApexcifyApp extends StatelessWidget {
  const ApexcifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApexcifyTechnologys',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A84FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
      ),
      home: const ProfileScreen(),
    );
  }
}
