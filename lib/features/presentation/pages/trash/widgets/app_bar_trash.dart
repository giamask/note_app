import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppBarTrash extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTrash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Trash').tr(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
