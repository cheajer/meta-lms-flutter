import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';


class VideoPlayerScreen extends StatefulWidget {
  final ChewieController chewieController;

  const VideoPlayerScreen({Key? key, required this.chewieController}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Chewie(
        controller: widget.chewieController,
      ),
    );
  }

  @override
  void dispose() {
    widget.chewieController.videoPlayerController.dispose(); // Dispose of the VideoPlayerController
    widget.chewieController.dispose(); // Dispose of the ChewieController
    super.dispose();
  }
}
