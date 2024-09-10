part of 'pictures_cubit.dart';

sealed class PicturesState extends Equatable {
  final List<File> files;

  const PicturesState(this.files);

  @override
  List<Object> get props => files.map((x) => x.hashCode).toList();
}

final class PicturesInitial extends PicturesState {
  const PicturesInitial(super.files);
}
