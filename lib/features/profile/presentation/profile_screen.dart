import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../features/auth/presentation/auth_controller.dart';
import '../../../shared/widgets/app_page.dart';
import '../../../shared/widgets/section_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).user;

    return AppPage(
      title: 'Profile',
      actions: [
        IconButton(
          tooltip: 'Edit profile',
          onPressed: () => context.goNamed(AppRoutes.editProfile),
          icon: const Icon(Icons.edit_outlined),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 36,
            child: Text(
              (user?.name.isNotEmpty == true ? user!.name[0] : 'U')
                  .toUpperCase(),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user?.name ?? 'User',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(user?.email ?? '', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          SectionCard(
            children: [
              ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: const Text('Phone'),
                subtitle: Text(user?.phone ?? 'Not set'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.password_outlined),
                title: const Text('Change password'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.goNamed(AppRoutes.changePassword),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
