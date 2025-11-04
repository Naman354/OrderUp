import 'package:client/features/auth/data/models/session_model.dart';
import 'package:client/features/menu/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'core/colors.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  Hive.registerAdapter(SessionModelAdapter());
  await Hive.openBox<SessionModel>('session');

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );


}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkIfLoggedIn() async {
    final box = await Hive.openBox<SessionModel>('session');
    final session = box.get('current_session');
    return session != null && session.token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkIfLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          final bool isLoggedIn = snapshot.data ?? false;
          return MaterialApp(
            title: 'OrderUp',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.dark(
                primary: AppColors.mainOrange,
                secondary: AppColors.mainOrangeDark,
                surface: AppColors.secondaryDark,
              ),
              scaffoldBackgroundColor: AppColors.primaryDark,
              useMaterial3: true,
            ),
            home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
          );
        }
      },
    );
  }
}
