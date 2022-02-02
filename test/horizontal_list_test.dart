import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizontal_list/horizontal_list.dart';

void main() {
  Widget makeTestable(Widget widget) => MaterialApp(home: widget);

  testWidgets('test my widget', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestable(const HorizontalListView(
      height: 200,
      width: double.maxFinite,
      iconNext: Icon(Icons.arrow_forward_ios),
      iconPrevious: Icon(Icons.arrow_back_ios),
      list: [Text('1'), Text('2')],
    )));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    final l1Finder = find.text('1');
    final l2Finder = find.text('2');
    final l3Finder = find.text('3');

    expect(l1Finder, findsOneWidget);
    expect(l2Finder, findsOneWidget);
    expect(l3Finder, findsNothing);
  });
}
