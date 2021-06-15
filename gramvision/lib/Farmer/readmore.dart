import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'Carousel.dart';

class Readmore extends StatefulWidget {
  Readmore() : super();
  final String title = "Video Demo";
  @override
  _ReadmoreState createState() => _ReadmoreState();
}

class _ReadmoreState extends State<Readmore> {
  //VideoPlayerController _controller;
  // ignore: deprecated_member_use
  List<VideoPlayerController> _con=new List<VideoPlayerController>(2);
  Future<void> _initializeVideoPlayerFuture;

  void initState() {
    _con[0]= VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _con[0].initialize();
    _con[0].setLooping(true);
    _con[0].setVolume(1.0);

    //next video
    _con[1]= VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _con[1].initialize();
    _con[1].setLooping(true);
    _con[1].setVolume(1.0);
    super.initState();
    // _controller = VideoPlayerController.network(
    //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    // //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    // _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true);
    // _controller.setVolume(1.0);
    // super.initState();
  }
 
  @override
  void dispose() {
    _con[0].dispose();
    _con[1].dispose();
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read More"),
      ),
      body: ListView(
        children: [
          Carousel(),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                    //aspectRatio: _controller.value.aspectRatio,
                    //child: VideoPlayer(_controller),
                    aspectRatio: _con[0].value.aspectRatio,
                    child: VideoPlayer(_con[0]),

                  
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                // if (_controller.value.isPlaying) {
                //   //_controller.pause();
                //   _con[0].pause();
                // } else {
                //   //_controller.play();
                //   _con[0].play();
                // }
                if (_con[0].value.isPlaying) {
                  _con[0].pause();
                } else {
                  _con[0].play();
                }
              });
            },
            child:
                //Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                Icon(_con[0].value.isPlaying ? Icons.pause : Icons.play_arrow),

          ),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                    aspectRatio: _con[1].value.aspectRatio,
                    child: VideoPlayer(_con[1]),

                  
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_con[1].value.isPlaying) {
                  _con[1].pause();
                } else {
                  _con[1].play();
                }
              });
            },
            child:
                //Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                Icon(_con[1].value.isPlaying ? Icons.pause : Icons.play_arrow),

          ),
        ],
      )

    );
  }
}