import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_assessment_jan_2025/screens/products/bloc/products_bloc.dart';

import 'providers/cart_provider.dart';
import 'screens/cart/bloc/cart_bloc.dart';
import 'screens/home_screen.dart';
import 'screens/cart/views/cart_screen.dart';
import 'services/get_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<ProductsBloc>()..add(FetchProducts())),
        BlocProvider(create: (context) => getIt<CartBloc>())
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'E-commerce App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
          routes: {
            CartScreen.routeName: (ctx) => const CartScreen(),
          },
        );
      }),
    );
  }
}
