import 'package:flickr_clean/features/wallpaper/presentation/pages/search_screen.dart';
import 'package:flickr_clean/features/wallpaper/presentation/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/api_strings.dart';
import '../bloc/images_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(
                    text: 'Wallpaper', style: TextStyle(color: Colors.black87)),
                TextSpan(text: 'Apps', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          elevation: 0.0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchScreen())),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10,),
                    Icon(
                      Icons.search,
                      color: Colors.black.withOpacity(0.7),
                      size: 20,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'Search',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const _bodyBuilder(),
        ],
      ),
    );
  }
}

class _bodyBuilder extends StatelessWidget {
  const _bodyBuilder();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ImagesBloc, ImagesState>(
        builder: (context, state) {
          if (state is LoadingImagesState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedImagesState) {
            var images = context.read<ImagesBloc>().list;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                  // PagewiseGridView.count(
                  //   pageSize: 10,
                  //   crossAxisCount: 2,
                  //   mainAxisSpacing: 10.0,
                  //   crossAxisSpacing: 10.0,
                  //   childAspectRatio: 0.555,
                  //   padding: const EdgeInsets.all(15.0),
                  //   itemBuilder: (context, entry, index) {
                  //     return RoundedImageCard(
                  //       imageUrl: ApiConstants.imageUrl(
                  //         state.imagesData[index].secret,
                  //         state.imagesData[index].server,
                  //         state.imagesData[index].id,
                  //       ),
                  //       title: state.imagesData[index].title,
                  //     );
                  //   },
                  //   pageFuture: (pageIndex) async {
                  //     sl<ImagesBloc>()
                  //         .add(GetRecentImagesNextPageEvent(pageIndex: pageIndex!-1));
                  //     return state.imagesData;
                  //   },
                  // )
                  GridView.builder(
                controller: context.read<ImagesBloc>().scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  if (index >= images.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return RoundedImageCard(
                      imageUrl: ApiConstants.imageUrl(
                        images[index].secret,
                        images[index].server,
                        images[index].id,
                      ),
                      title: images[index].title,
                    );
                  }
                },
                itemCount: context.read<ImagesBloc>().isLoadingMore
                    ? images.length + 1
                    : images.length,
              ),
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
