import 'package:damy/screens/session_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Valida campos e lista partidas com códigos distintos', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SessionScreen()));
    await tester.tap(find.text('Gerar partida'));
    await tester.pump();
    expect(find.text('Informe o nome da sessão'), findsOneWidget);
    expect(find.text('Informe uma quantidade maior que zero'), findsOneWidget);

    for (final name in ['Partida A', 'Partida B']) {
      await tester.enterText(find.byType(TextFormField).at(0), name);
      await tester.enterText(find.byType(TextFormField).at(1), '4');
      await tester.tap(find.text('Gerar partida'));
      await tester.pumpAndSettle();
    }

    final descriptions = tester
        .widgetList<Text>(find.byType(Text))
        .map((text) => text.data ?? '')
        .where((text) => text.startsWith('Participantes:'))
        .toList();
    expect(descriptions, hasLength(2));
    for (final description in descriptions) {
      expect(
        description,
        matches(RegExp(r'^Participantes: 4\nCódigo da sala: [1-9][0-9]{4}$')),
      );
    }
    expect(descriptions.toSet(), hasLength(2));

    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(const MaterialApp(home: SessionScreen()));
    expect(find.text('Partida A'), findsOneWidget);
    expect(find.text('Partida B'), findsOneWidget);
  });
}
