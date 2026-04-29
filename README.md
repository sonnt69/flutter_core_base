# Flutter Core Base

A production-ready Flutter starter kit for mobile products. The app ships with a complete auth/account shell, feature-first folders, Riverpod state management, `go_router`, Dio with auth refresh structure, Isar local persistence, secure token storage, environment entrypoints, shared UI states, and a theme system.

## Included Flows

- Splash and startup routing
- Onboarding
- Login, register, forgot password, OTP verification
- Home
- Profile and edit profile
- Change password
- Settings
- Privacy Policy and Terms of Service
- Delete account
- Logout

## Core Stack

- State management: `flutter_riverpod`
- Routing: `go_router`
- HTTP: `dio`
- Local DB: `isar` and `isar_flutter_libs`
- Secure storage: `flutter_secure_storage`
- Code generation: `build_runner` and `isar_generator`

## Project Structure

```text
lib/
  app/
    app.dart
    bootstrap.dart
    router/
    theme/
  core/
    config/
    database/
    errors/
    network/
    storage/
  features/
    auth/
      data/
      domain/
      presentation/
    home/
    legal/
    onboarding/
    profile/
    settings/
  shared/
    extensions/
    widgets/
```

## Environments

The app has separate entrypoints for each environment:

```bash
flutter run -t lib/main.dart
flutter run -t lib/main_staging.dart
flutter run -t lib/main_prod.dart
```

Update API hosts in `lib/core/config/environment.dart`.

## API Layer

`lib/core/network/api_client.dart` creates the configured Dio client. `AuthInterceptor` attaches bearer tokens and contains the refresh-token retry structure:

- Reads access and refresh tokens from secure storage
- Adds `Authorization: Bearer <token>` to protected requests
- On `401`, calls `/auth/refresh`
- Stores refreshed tokens
- Retries the original request
- Clears tokens if refresh fails

The auth remote data source currently returns local demo responses so the starter runs immediately. Replace those methods with real `ApiClient` calls when connecting a backend.

## Local DB Layer

Isar is initialized in `lib/core/database/isar_database.dart` and currently stores the current user profile in `UserProfileCache`.

After editing Isar entities, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Secure Token Storage

`SecureTokenStorage` stores:

- Access token
- Refresh token
- Onboarding completion flag

Use this class rather than reading `FlutterSecureStorage` directly from feature modules.

## Adding A New Feature Module

Create a folder under `lib/features/<feature_name>`:

```text
lib/features/orders/
  data/
    orders_remote_data_source.dart
    orders_repository.dart
  domain/
    order.dart
  presentation/
    orders_screen.dart
    order_details_screen.dart
```

Recommended steps:

1. Define domain models in `domain/`.
2. Add remote/local data sources in `data/`.
3. Expose a repository provider from `data/`.
4. Add a controller provider if the feature has screen state or mutations.
5. Build screens in `presentation/`.
6. Register routes in `lib/app/router/app_router.dart`.
7. Add shared widgets only when multiple features will reuse them.
8. Add Isar entities under `lib/core/database/entities` or the feature data folder, then add their schemas to `IsarDatabase.open`.
9. Run `dart format lib test`, `flutter analyze`, and `flutter test`.

## Useful Commands

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format lib test
flutter analyze
flutter test
```

## Notes For Real Products

- Replace demo auth responses in `AuthRemoteDataSource` with backend calls.
- Replace legal placeholder text with product-specific documents.
- Review token refresh payload names against your API contract.
- Decide whether feature entities should live in `core/database/entities` or inside each feature based on ownership and reuse.
- Add integration tests for critical auth and account flows before release.
