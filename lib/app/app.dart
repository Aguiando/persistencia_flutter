import 'package:flutter/material.dart';
import '../presentation/pages/pessoas_page.dart';


/// Widget principal da aplicação
/// Configura MaterialApp com tema e roteamento

class PessoasApp extends StatelessWidget {
  const PessoasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistência Local (SQLite)',
       debugShowCheckedModeBanner: false,

      // Tema da aplicação
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // Tema escuro
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
      ),

      // Página inicial
      home: const PessoasPage(),
    );
  }
}