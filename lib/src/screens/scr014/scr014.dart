/*
 * File: scr014.dart
 * Project: CVideo
 * File Created: Monday, 13th July 2020 12:45 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:07 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'package:chewie/chewie.dart';
import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:cvideo_mobile/src/models/scr008/scr008_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class SCR014 extends StatefulWidget {
  const SCR014({Key key}) : super(key: key);

  @override
  _SCR014State createState() => _SCR014State();
}

class _SCR014State extends State<SCR014> {
  ChewieController chewieController;
  VideoPlayerController videoPlayerController;
  SCR014Arguments args;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context).settings.arguments;
      });

      /// Get video player controller
      videoPlayerController =
          VideoPlayerController.network(args.videoInfo.videoUrl);

      /// Configure Chewie controlelr
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        autoInitialize: true,
        aspectRatio: args.videoInfo.aspectRatio,
        placeholder: Center(
          child: Image.network(args.videoInfo.coverUrl),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        width: size.width,
        height: size.height,
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (chewieController != null) chewieController.dispose();
    if (videoPlayerController != null) videoPlayerController.dispose();
  }
}

class SCR014Arguments {
  final VideoInfo videoInfo;

  SCR014Arguments({this.videoInfo});
}
