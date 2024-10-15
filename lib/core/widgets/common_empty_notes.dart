import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:note_app/core/core.dart';

class CommonEmptyNotes extends StatelessWidget {
  const CommonEmptyNotes(this.drawerViewNote) : super(key: null);

  final DrawerSectionView drawerViewNote;

  @override
  Widget build(BuildContext context) {
    return _switchEmptySection(context, drawerViewNote);
  }

  _switchEmptySection(BuildContext context, DrawerSectionView drawerViewNote) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        return CommonFixScrolling(
          onRefresh: () => AppFunction.onRefresh(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcons.emptyNote,
                const SizedBox(height: 10.0),
                const Text(
                  'Notes you add appear here',
                  style: TextStyle(color: Colors.black54),
                ).tr()
              ],
            ),
          ),
        );
      case DrawerSectionView.archive:
        return _emptySection(
          AppIcons.emptyArchivesNote,
          'Your archived notes appear here',
        );
      case DrawerSectionView.trash:
        return _emptySection(
          AppIcons.emptyTrashNote,
          'No notes in the trash',
        );
    }
  }

  _emptySection(Icon appIcons, String errorMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [appIcons, const SizedBox(height: 5.0), Text(errorMsg).tr()],
      ),
    );
  }
}
