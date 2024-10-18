import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../blocs/blocs.dart';
import './widgets.dart';

class AppBarNote extends StatelessWidget implements PreferredSizeWidget {
  const AppBarNote({
    Key? key,
    required this.press,
  }) : super(key: key);

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusIconsCubit, StatusIconsState>(
      buildWhen: (previous, current) => current is ReadOnlyState,
      builder: (context, state) {
        final currentStatus = state is ReadOnlyState;

        const leadingIcon = AppIcons.arrowBack;
        List<Widget> actions;

        actions = currentStatus
            ? []
            : [const IconPinnedStatus(), const IconArchiveStatus()];

        return AppBar(
          leading:  IconButton(
            icon: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
               leadingIcon,
               SizedBox(width: 5.0,),
                Text('&'),
               SizedBox(width: 5.0,),
                Icon(Icons.save),
              ],
            ), onPressed: press,
          ),
          leadingWidth: 90,
          actions: actions,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
