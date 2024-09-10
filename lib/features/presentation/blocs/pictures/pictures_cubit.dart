import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pictures_state.dart';

class PicturesCubit extends Cubit<PicturesState> {
  PicturesCubit() : super(const PicturesInitial([]));

  void addPicture(File picture) {
    final newPictures = [...state.files, picture];
    emit(PicturesInitial(newPictures));
  }

  void initializePictures(List<File> pictures) {
    emit(PicturesInitial(pictures));
  }

  void reset() {
    emit(const PicturesInitial([]));
  }

  void removePicture(int index) {
    final newPictures = [...state.files];
    newPictures.removeAt(index);
    emit(PicturesInitial(newPictures));
  }
}
