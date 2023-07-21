import 'package:flutter/material.dart';
import 'package:mini_projet_mobile/controller.dart';
import 'package:mini_projet_mobile/photo_colorization.dart';
import 'package:mini_projet_mobile/video_colorization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'BW2RGB',
            // style: TextStyle(
            //   fontFamily: 'GreatVibes',
            // ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.photo),
                text: 'Photo',
              ),
              Tab(
                icon: Icon(Icons.videocam_rounded),
                text: 'Video',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PhotoColorization(),
            VideoColorization(),
          ],
        ),
      ),
    );
  }
}
