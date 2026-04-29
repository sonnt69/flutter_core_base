import 'package:flutter/material.dart';

import '../../../shared/widgets/app_page.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Terms of Service',
      child: Text(
        'Replace this starter text with your terms. Include eligibility, acceptable use, account responsibilities, subscriptions, termination, warranty disclaimers, liability limits, and governing law.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
