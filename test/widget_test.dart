import 'package:flutter_test/flutter_test.dart';
import 'package:os_learning_platform/app/app.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const OsLearningApp());
    expect(find.text("Let’s jump in, Yashas!"), findsOneWidget);
  });
}
