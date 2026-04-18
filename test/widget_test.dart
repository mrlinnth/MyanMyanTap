import 'package:flutter_test/flutter_test.dart';
import 'package:myan_myan_tap/main.dart';

void main() {
  testWidgets('App renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const MyanMyanTapApp());
    expect(find.text('Start Screen'), findsOneWidget);
  });
}
