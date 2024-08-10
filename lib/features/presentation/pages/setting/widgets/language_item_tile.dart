import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class LanguageItemTile extends StatelessWidget {
  const LanguageItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Language').tr(),
      trailing: Text(
        context.locale.languageCode == 'en' ? 'English' : 'Ελληνικα',
        style: context.textTheme.bodyLarge,
      ),
      leading: const Icon(Icons.language),
      onTap: () => context.setLocale(context.locale.languageCode == 'en'
          ? const Locale('el', 'GR')
          : const Locale('en', 'US')),
    );
  }
}
