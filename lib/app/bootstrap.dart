import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/environment.dart';
import '../core/database/isar_database.dart';
import 'app.dart';

Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvironmentConfig.setEnvironment(environment);

  final database = await IsarDatabase.open();

  runApp(
    ProviderScope(
      overrides: [isarDatabaseProvider.overrideWithValue(database)],
      child: const CoreBaseApp(),
    ),
  );
}
