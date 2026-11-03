import 'package:damy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Mantém temas criados e editados ao trocar de aba', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.tap(find.text('Tema'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Novo tema'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Energia nuclear');
    await tester.enterText(find.byType(TextFormField).at(1), 'Descrição do tema');
    await tester.tap(find.text('Salvar tema'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Meu dia'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tema'));
    await tester.pumpAndSettle();
    expect(find.text('Energia nuclear'), findsOneWidget);
    expect(find.text('Descrição do tema'), findsOneWidget);

    await tester.tap(find.byTooltip('Editar tema'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Tema atualizado');
    await tester.enterText(find.byType(TextFormField).at(1), 'Descrição atualizada');
    await tester.tap(find.text('Salvar alterações'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Meu dia'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tema'));
    await tester.pumpAndSettle();
    expect(find.text('Tema atualizado'), findsOneWidget);
    expect(find.text('Descrição atualizada'), findsOneWidget);
    expect(find.text('Energia nuclear'), findsNothing);
  });
}
