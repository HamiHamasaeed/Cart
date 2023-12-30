import 'package:codify100/cart_provider.dart';
import 'package:codify100/cart_screen.dart';
import 'package:codify100/product_list.dart';
// import 'package:codify100/product_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _route = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const ProductListScreen(),
  ),
  GoRoute(path: "/cart", builder: (context, state) => const CartScreen())
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp.router(
          title: 'Codify',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 0, 0, 0)),
            useMaterial3: true,
          ),
          routerConfig: _route,
        );
      }),
    );
  }
}
