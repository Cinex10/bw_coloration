import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mini_projet_mobile/app_constance.dart';
import 'package:mini_projet_mobile/controller.dart';
import 'package:video_player/video_player.dart';

class VideoResultScreen extends StatefulWidget {
  const VideoResultScreen({
    super.key,
    required this.original,
    required this.colorized,
  });
  final String original;
  final String colorized;
  @override
  State<VideoResultScreen> createState() => _VideoResultScreenState();
}

class _VideoResultScreenState extends State<VideoResultScreen> {
  bool _downloading = false;
  String _progressString = '';
  int rec = 0;
  int total = 1;

  double sliderPostion = 0;

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'http://192.168.0.105:8000/files/bw_edited.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.addListener(() {
      setState(() {
        var v = _controller.value.position.inMilliseconds /
            _controller.value.duration.inMilliseconds;
        sliderPostion = (v.isNaN) ? 0 : v;
      });
      print(sliderPostion);
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    _controller.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(sliderPostion);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          // style: TextStyle(
          //   fontFamily: 'GreatVibes',
          // ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            Slider(
              min: 0,
              value: sliderPostion,
              max: _controller.value.duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                Duration position = Duration(
                    milliseconds:
                        (value * _controller.value.duration.inMilliseconds)
                            .toInt());
                print(value * _controller.value.position.inMilliseconds);
                _controller.seekTo(position);
              },
            ),
            const Spacer(),
            // Expanded(
            //   flex: 5,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(15.0),
            //     child: Image.network(
            //       '${AppConstance.host}/files/${widget.colorized}',
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            (!_downloading)
                ? const Spacer(
                    flex: 2,
                  )
                : Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: LinearProgressIndicator(
                            value: rec / total,
                            minHeight: 6.0,
                          ),
                        ),
                        Text("${((rec / total) * 100).toStringAsFixed(0)}%")
                      ],
                    ),
                  ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _controller.seekTo(Duration(milliseconds: 0));
                  return;
                  Controller().saveImage(
                      '${AppConstance.host}/files/bw_images (1).jpeg',
                      'bw_images (1).jpeg', (rec_, total_) {
                    setState(() {
                      print(rec / total);
                      _downloading = true;
                      _progressString =
                          "${((rec / total) * 100).toStringAsFixed(0)}%";

                      rec = rec_;
                      total = total_;
                      // if (rec == total){
                      //   _downloading
                      // }
                    });
                  });
                },
                icon: const Icon(Icons.save),
                label: const Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          print(_controller.value.duration);
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
