import 'package:dart_demo/src/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders analyzer demo app shell', (WidgetTester tester) async {
    await tester.pumpWidget(const AnalyzerDemoApp());

    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Analysis'), findsWidgets);
    expect(find.text('Engineer'), findsOneWidget);
  });
}
