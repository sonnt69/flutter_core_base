import 'app/bootstrap.dart';
import 'core/config/environment.dart';

Future<void> main() async {
  await bootstrap(AppEnvironment.prod);
}
