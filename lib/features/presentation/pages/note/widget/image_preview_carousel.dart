import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/presentation/blocs/pictures/pictures_cubit.dart';
import 'package:note_app/features/presentation/pages/note/widget/image_preview_bar.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewCarousel extends StatefulWidget {
  final String index;
  const ImagePreviewCarousel({Key? key, required this.index}) : super(key: key);

  @override
  State<ImagePreviewCarousel> createState() => _ImagePreviewCarouselState();
}

class _ImagePreviewCarouselState extends State<ImagePreviewCarousel> {
  late final int index;
  late final PageController _pageViewController;

  @override
  void initState() {
    index = int.tryParse(widget.index) ?? 0;
    _pageViewController = PageController(initialPage: index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: PageView.builder(
        itemCount: context.read<PicturesCubit>().state.files.length,
        controller: _pageViewController,
        itemBuilder: (BuildContext context, int index) {
          return BlocBuilder<PicturesCubit, PicturesState>(
              builder: (context, state) {
            return Scaffold(
              appBar: ImagePreviewBar(index: index, total: state.files.length),
              body: PhotoView(
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
                imageProvider: Image.file(state.files[index]).image,
                initialScale: PhotoViewComputedScale.contained,
              ),
            );
          });
        },
      ),
    );
  }
}
