import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/auth/presentation/auth_controller.dart';
import '../../../shared/widgets/app_page.dart';

class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  ConsumerState<DeleteAccountScreen> createState() =>
      _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen> {
  var _isLoading = false;

  Future<void> _deleteAccount() async {
    setState(() => _isLoading = true);
    await ref.read(authControllerProvider.notifier).deleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Delete account',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Deleting your account clears local data and signs you out. Wire this action to your backend account deletion endpoint before shipping.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          FilledButton.tonalIcon(
            onPressed: _isLoading ? null : _deleteAccount,
            icon: const Icon(Icons.delete_outline),
            label: Text(_isLoading ? 'Deleting...' : 'Delete account'),
          ),
        ],
      ),
    );
  }
}
