import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/features/presentation/blocs/pictures/pictures_cubit.dart';
import '../../../../../core/core.dart';

class ImagePreviewBar extends StatelessWidget implements PreferredSizeWidget {
  final int index;
  final int total;
  const ImagePreviewBar({
    Key? key,
    required this.index,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const leadingIcon = AppIcons.arrowBack;

    return AppBar(
      title: Text('${index + 1} ${tr('of')} $total'),
      leading: IconButton(
        icon: leadingIcon,
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: AppIcons.trashNote,
          onPressed: () {
            context.read<PicturesCubit>().removePicture(index);
            if (context.mounted) context.pop();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
