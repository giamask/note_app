import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:note_app/features/presentation/pages/setting/widgets/language_item_tile.dart';

import 'widgets/widgets.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings').tr()),
      body: const Sections(
        sections: [
          TilesSection(
              title: 'Display options',
              tiles: [ThemesItemTile(), LanguageItemTile()]),
        ],
      ),
    );
  }
}
