import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exemplo/app/app.dart';

void main() {
  testWidgets('App should build without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const PessoasApp());
    
    expect(find.text('Pessoas (SQLite)'), findsOneWidget);
    expect(find.text('Nenhuma pessoa cadastrada.'), findsOneWidget);
  });
}