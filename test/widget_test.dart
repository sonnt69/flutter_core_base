import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_core_base/shared/widgets/state_views.dart';

void main() {
  testWidgets('empty state renders title and message', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyView(
            title: 'No data',
            message: 'Create your first item to get started.',
          ),
        ),
      ),
    );

    expect(find.text('No data'), findsOneWidget);
    expect(find.text('Create your first item to get started.'), findsOneWidget);
  });
}
