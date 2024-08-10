import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Sections(
        sections: [
          TilesSection(title: 'Display option', tiles: [ThemesItemTile()]),
        ],
      ),
    );
  }
}
