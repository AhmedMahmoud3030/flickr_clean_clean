import 'package:flickr_clean/core/strings/api_strings.dart';
import 'package:flickr_clean/features/wallpaper/presentation/bloc/images_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/image_card.dart';
import '../widgets/my_drawer.dart';
import 'image_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawer(),
        body: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => context
                        .read<ImagesBloc>()
                        .add(SearchRecentImagesEvent(query: value)),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.white12,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<ImagesBloc, ImagesState>(
                  builder: (context, state) {
                if (state is LoadingImagesState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedImagesState) {
                  var images = context.read<ImagesBloc>().searchList;
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageView(
                                  image: images[index],
                                ),
                              ),
                            ),
                            child: RoundedImageCard(
                              imageUrl: ApiConstants.imageUrl(
                                images[index].secret,
                                images[index].server,
                                images[index].id,
                              ),
                              title: images[index].title,
                            ),
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
              }),
            )
          ],
        ),
      ),
    );
  }
}
