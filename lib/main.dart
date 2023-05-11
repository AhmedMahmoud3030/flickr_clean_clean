import 'package:flickr_clean/features/wallpaper/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import "core/injection.dart" as di;
import 'features/wallpaper/presentation/bloc/images_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ImagesBloc>()..add(GetRecentImagesEvent()),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),

      ),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //         create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
    //     BlocProvider(create: (_) => di.sl<ChangePostBloc>()),
    //   ],
    //   child: const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: MyHomePage(),
    //   ),
    // );
  }
}
