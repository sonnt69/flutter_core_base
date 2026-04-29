import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../features/auth/presentation/auth_controller.dart';
import '../../../shared/widgets/app_page.dart';
import '../../../shared/widgets/section_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppPage(
      title: 'Settings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionCard(
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode_outlined),
                title: const Text('Use system theme'),
                value: true,
                onChanged: null,
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.goNamed(AppRoutes.privacyPolicy),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const Text('Terms of Service'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.goNamed(AppRoutes.termsOfService),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            children: [
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Delete account'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.goNamed(AppRoutes.deleteAccount),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () => ref.read(authControllerProvider.notifier).logout(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
