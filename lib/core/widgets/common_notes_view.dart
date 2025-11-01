import 'package:flutter/widgets.dart';

import '../../features/domain/entities/note.dart';
import '../../features/presentation/pages/home/widgets/widgets.dart';
import '../core.dart';

class CommonNotesView extends StatelessWidget {
  const CommonNotesView(
      {Key? key,
      required this.drawerSection,
      required this.otherNotes,
      required this.pinnedNotes,
      this.decorativeImage})
      : super(key: key);

  final DrawerSectionView drawerSection;
  final List<Note> otherNotes;
  final List<Note> pinnedNotes;
  final String? decorativeImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorativeImage != null
          ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage(decorativeImage!),
                fit: BoxFit.fitHeight,
                scale: 0.55,
                opacity: 0.7,
                alignment: const Alignment(0.3, 0),
              ),
            )
          : null,
      child: CustomScrollView(
        slivers:
            _switchNotesSectionView(drawerSection, otherNotes, pinnedNotes),
      ),
    );
  }

  List<Widget> _switchNotesSectionView(
    DrawerSectionView drawerViewNote,
    List<Note> otherNotes,
    List<Note> pinnedNotes,
  ) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        return [
          pinnedNotes.isNotEmpty
              ? const HeaderText(text: 'Pinned')
              : const SliverToBoxAdapter(),
          GridNotes(notes: pinnedNotes, isShowDismisse: false),
          const HeaderText(text: 'Other'),
          GridNotes(notes: otherNotes, isShowDismisse: false),
          const SliverToBoxAdapter(child: SizedBox(height: 120))
        ];
      case DrawerSectionView.archive:
        return [GridNotes(notes: otherNotes, isShowDismisse: false)];
      case DrawerSectionView.trash:
        return [GridNotes(notes: otherNotes, isShowDismisse: false)];
    }
  }
}
