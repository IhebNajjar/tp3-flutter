import 'package:flutter_test/flutter_test.dart';
import 'package:waiting_room_app/waiting_room_card.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets(
    'WaitingRoomCard displays the name correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WaitingRoomCard(name: 'Alice'),
        ),
      );

      expect(find.text('Hello,'), findsOneWidget);
      expect(find.text('Alice'), findsOneWidget);
    },
  );

  testWidgets(
    'WaitingRoomCard changes its background color when tapped',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WaitingRoomCard(name: 'Alice'),
        ),
      );

      Card card = tester.widget<Card>(find.byType(Card));
      expect(card.color, isNull);

      await tester.tap(find.byType(WaitingRoomCard));
      await tester.pump();

      card = tester.widget<Card>(find.byType(Card));
      expect(card.color, Colors.lightBlueAccent);
    },
  );
}