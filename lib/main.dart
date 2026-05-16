import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/auth_cubit.dart';
import 'bloc/theme/theme_cubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'VBHC',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const LoginScreen(),
      ),
    );
  }
}
