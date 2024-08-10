import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class AppBarAchive extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAchive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Archive').tr(),
      actions: [
        IconButton(
          onPressed: () => _showSearch(context),
          icon: AppIcons.searchNote,
        ),
        const IconStatusGridNote(),
      ],
    );
  }

  Future _showSearch(BuildContext context) {
    return showSearch(
      context: context,
      delegate: NotesSearching(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
