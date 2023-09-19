import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  Future<void> initializeVideo() async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    await videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        videoPlayerController.value.isPlaying ? videoPlayerController.pause() : videoPlayerController.play();
      },
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: videoPlayerController.value.isInitialized || videoPlayerController.value.isBuffering
              ? AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(
                    videoPlayerController,
                  ),
                )
              : const CircularProgressIndicator(
                  color: Colors.red,
                ),
        ),
      ),
    );
  }
}
