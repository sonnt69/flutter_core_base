import 'package:flutter/material.dart';

import '../../../shared/widgets/app_page.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Privacy Policy',
      child: Text(
        'Replace this starter text with your product privacy policy. Cover what data is collected, why it is collected, how it is stored, when it is shared, user rights, retention, and contact information.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
