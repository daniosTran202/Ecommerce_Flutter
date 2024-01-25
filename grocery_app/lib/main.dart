import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_app/pages/dashboard_page.dart';
import 'package:grocery_app/pages/home_page.dart';
import 'package:grocery_app/pages/login_page.dart';
import 'package:grocery_app/pages/product_page.dart';
import 'package:grocery_app/pages/register_page.dart';
import 'package:grocery_app/utils/shared_services.dart';

Widget _defaultHome = const LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedServices.isLoggedIn();

  if (_result) {
    _defaultHome = const DashboardPage();
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GroceryApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const RegisterPage(),
      routes: <String, WidgetBuilder>{
        '/': (context) => _defaultHome,
        '/register': (BuildContext context) => const RegisterPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/products': (BuildContext context) => const ProductsPage(),
      },
    );
  }
}
