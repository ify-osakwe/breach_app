# Breach

A Flutter app built with Riverpod, GoRouter, Dio, and Secure Storage.

Flutter 3.35.2 • Dart 3.9.0

## Overview

Breach demonstrates a small but complete flow:

- Splash → Register → Personalise Interests → Posts/Streams (tabbed) via GoRouter
- API integration (auth, categories, user interests) via Dio
- WebSocket stream for real-time items
- State management with Riverpod Notifiers and Providers
- Secure token and user-id storage
- Reusable scaffolding, loading overlays, and theming

## Quick Start

Prerequisites

- Flutter SDK: 3.35.2
- Dart SDK: 3.9.0
- Xcode/Android Studio toolchains for iOS/Android

Install and run

1) Fetch packages

   flutter pub get

2) Run on a device or simulator

   flutter run

The app starts at the Splash screen, then navigates to Register.

## App Flow

1) Splash (`lib/screens/splash/splash_screen.dart`)
   - Shows logo and after 1.5s navigates to Register.

2) Auth (`lib/screens/auth/...`)
   - Register: captures email/password, calls `BreachApi.register`, and stores `token` + `userId` in secure storage.
   - Login: authenticates existing users and stores credentials.
   - On successful register/login, navigates forward in the flow.

3) Personalise Interests (`lib/screens/personalise/...`)
   - Loads categories with `categoriesProvider`.
   - User selects interests; `saveUserInterests` posts them with auth header.
   - Navigates to Posts on success.

4) Main Tabs (`lib/screens/nav/nav_screen.dart`)
   - Two tabs via `StatefulShellRoute`: Posts and Streams.

5) Posts (`lib/screens/posts/...`)
   - Reads the user’s interests (`userInterestsProvider`) and shows chips to filter.

6) Streams (`lib/screens/streams/...`)
   - Connects to a WebSocket using the saved auth token.
   - Listens for items and shows a recent list.

## Project Structure

- lib/main.dart
  - App entry. Sets theme (Inter font, seeded colors) and attaches router config.

- lib/routes
  - `routes.dart`: central route names.
  - `routes_top.dart`: GoRouter with initial location and tab shell.
  - `routes_branches.dart`: nested routes stubs for tabs.

- lib/data
  - `breach_api.dart`: Facade composing endpoint mixins.
  - common/
    - `api_client.dart`: Configured Dio client, helpers to parse JSON/object and list responses, error mapping to `ApiResult<T>`.
    - `api_response_model.dart`: `ApiSuccess<T>`, `ApiFailure<T>`, `ApiError`, `EmptyResponse`.
    - `api_path.dart`: REST paths (QA base paths).
  - endpoints/
    - `auth_endpoints.dart`: register/login.
    - `users_endpoints.dart`: save/get user interests (requires Bearer token).
    - `blog_endpoints.dart`: get categories, posts by category.
  - models/
    - Auth: `auth_request.dart`, `auth_response.dart`.
    - Blog: `categories_list_reponse.dart`, `post_entity.dart`.
    - User: `user_interest_request.dart`, `user_interest_response.dart`.
    - Realtime: `stream_item.dart`.
  - local/
    - `secure_storage.dart`: wrapper around `flutter_secure_storage` (token, userId, username).

- lib/screens
  - splash/: splash screen.
  - auth/: auth state, notifier, and UI (`login_screen.dart`, `register_screen.dart`).
  - personalise/: state, notifier, intro UI + chips.
  - posts/: notifier for interests, UI stub for post list/filter.
  - streams/: stream provider, recent items notifier, widgets.
  - nav/: tab host and destination metadata.

- lib/utils
  - widgets/: `AppScaffold`, overlays, etc.
  - theme/: colors.
  - functions/: date formatting.

- assets
  - images/: app images (logo); fonts/: Inter families.

## Routing

- Configured with GoRouter in `lib/routes/routes_top.dart`.
- Initial route: `Routes.splash`.
- Tabs implemented with `StatefulShellRoute.indexedStack` and `NavScreen`.
- To change initial flow, edit `initialLocation` or target routes in notifiers.

## State Management

- Riverpod Notifiers for mutable state and actions:
  - `RegisterNotifier`, `LoginNotifier`, `PersonaliseNotifier`, `RecentStreamItemsNotifier`.
- `FutureProvider` for async loads:
  - `categoriesProvider`, `userInterestsProvider`, `streamNewsProvider` (StreamProvider).
- UI reads state with `ref.watch(...)` and triggers actions with `ref.read(...).method(...)`.

## Data & Networking

- Base URL and endpoints
  - Base: `ApiClient.baseUrl = https://breach-api.qa.mvm-tech.xyz`
  - Additional paths in `lib/data/common/api_path.dart`
  - To switch environments, update `ApiClient.baseUrl` and (optionally) `ApiPath`.

- HTTP
  - `ApiClient.getJson`, `postJson`, `postEmpty`, `getJsonList` wrap Dio calls.
  - Responses mapped to `ApiResult<T>`: either `ApiSuccess(data)` or `ApiFailure(error)`.
  - Pretty logging enabled in debug builds.

- WebSocket
  - `streamNewsProvider` connects to `wss://breach-api-ws.qa.mvm-tech.xyz?token=<jwt>`.
  - On each message, JSON is decoded to `StreamItem` and added to recent items.

- Local storage
  - `flutter_secure_storage` stores `auth_token`, `user_id`, `username`.
  - Helpers in `SecureStorage` for set/get/delete and `clearAll`.

## UI & Theming

- `AppScaffold` wraps `Scaffold` with shared padding, optional app bar, FAB, etc., and injects a loading overlay.
- `LoadingIndicatorOverlay` and `LinearLoadingIndicator` for async UX.
- `AppColors` centralizes color tokens; theme uses Inter font.

## How To Follow The Code

1) Entry point: `lib/main.dart` → `MaterialApp.router` → `goRouter`.
2) Routes: check `lib/routes/routes_top.dart` to see all top-level screens and tab branches.
3) Feature flows:
   - Register/Login → Notifiers in `lib/screens/<feature>/notifier`, models in `lib/screens/<feature>/model`, UI in `lib/screens/<feature>/ui`.
   - Personalise → `categoriesProvider` fetch + `PersonaliseNotifier.saveUserInterests`.
   - Posts → `userInterestsProvider` for interests; plug in `getPostsByCategory` for list data.
   - Streams → `streamNewsProvider` and `RecentStreamItemsNotifier` to manage displayed items.
4) Networking: start at `lib/data/breach_api.dart`, drill into endpoint mixins and `ApiClient`.
5) Models: in `lib/data/models`, each with `fromJson`/`toJson`.

## What’s Implemented

- Auth: register and login endpoints, saving token and userId securely.
- Interests: fetch categories, select interests, save to backend.
- Posts: basic interest chips UI; ready to hook into posts API.
- Streams: live feed via WebSocket with recent-items store.
- Navigation: Splash → Auth → Personalise → Tabs (Posts/Streams).
- Reusable UI shell with progress overlays.

## Android APK Build

Use the helper script in the repo root to create a release APK.

Basic usage

```
bash build_mobile.sh
```

Options

- `--clean`: run `flutter clean` before building
- `--build-number <num>`: override build number
- `--build-name <name>`: override build name (e.g., 1.2.3)
- `-v`/`--verbose`: verbose Flutter output
- `-h`/`--help`: show script help

Examples

```
# Default release APK
bash build_mobile.sh

# Clean build with version overrides
bash build_mobile.sh --clean --build-number 42 --build-name 1.2.3
```

Artifacts

- The APK is written under `build/app/outputs/flutter-apk/` (the script prints found files after the build).

Notes

- Ensure you have the Android toolchain installed (`flutter doctor`).
- For a signed release, configure signing in `android/app/build.gradle.kts` before running the script.
