import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show sqfliteFfiInit, databaseFactoryFfi;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'
    show databaseFactoryFfiWeb;

import 'app/app.dart';
import 'core/di/dependency_injection.dart';
import 'presentation/viewmodels/pessoas_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureSQLite();

  await setupDependencyInjection();

  runApp(const PessoasApp());
}
  
  /// Configura SQLite para diferentes plataformas
Future<void> _configureSQLite() async {
  if (kIsWeb) {
    // Web: usar SQLite via IndexedDB
    databaseFactory = databaseFactoryFfiWeb;
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Desktop: inicializar SQLite FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

 // Android/iOS: usar SQLite nativo (configuração automática)
}