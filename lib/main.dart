import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/user/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VBHCApp());
}

class VBHCApp extends StatelessWidget {
  const VBHCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VBHC',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
    );
  }
}
