import 'package:dart_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login page renders expected fields', (WidgetTester tester) async {
    await tester.pumpWidget(const LoginDemoApp());

    expect(find.text('欢迎登录'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '邮箱'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '密码'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '登录'), findsOneWidget);
  });
}
