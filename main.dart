import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/auth_screens.dart';
import 'screens/create_transaction_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/receipt_screen.dart';
import 'screens/shell.dart';
import 'screens/splash_screen.dart';
import 'screens/support_screen.dart';
import 'screens/track_screen.dart';
import 'screens/welcome_screen.dart';
import 'state.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Portrait only.
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MiddleBankApp());
}

class MiddleBankApp extends StatefulWidget {
  const MiddleBankApp({super.key});

  @override
  State<MiddleBankApp> createState() => _MiddleBankAppState();
}

class _MiddleBankAppState extends State<MiddleBankApp> {
  final AppState _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      child: MaterialApp(
        title: 'MIDDLE BANK',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        // Keep layouts intact when users set very large system fonts.
        builder: (context, child) {
          final mq = MediaQuery.of(context);
          return MediaQuery(
            data: mq.copyWith(
              textScaler: mq.textScaler.clamp(
                minScaleFactor: 0.9,
                maxScaleFactor: 1.2,
              ),
            ),
            child: child!,
          );
        },
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashScreen(),
          '/welcome': (_) => const WelcomeScreen(),
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/buyer': (_) => const MainShell(seller: false),
          '/seller': (_) => const MainShell(seller: true),
          '/create': (_) => const CreateTransactionScreen(),
          '/pay': (_) => const PaymentScreen(),
          '/receipt': (_) => const ReceiptScreen(),
          '/track': (_) => const TrackScreen(),
          '/support': (_) => const SupportScreen(),
        },
      ),
    );
  }
}
