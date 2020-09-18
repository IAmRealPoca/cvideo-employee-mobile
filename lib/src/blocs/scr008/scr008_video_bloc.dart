/*
 * File: scr008_video_bloc.dart
 * Project: CVideo
 * File Created: Monday, 13th July 2020 12:45 pm
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Monday, 13th July 2020 5:08 pm
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'dart:convert';

import 'package:cvideo_mobile/src/blocs/scr008/scr008_bloc_barrel.dart';
import 'package:cvideo_mobile/src/models/scr008/scr008_models.dart';
import 'package:cvideo_mobile/src/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_publitio/flutter_publitio.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  static const _PUBLITIO_PREFIX = "https://media.publit.io/file";
  static final _platform =
      MethodChannel("com.fptu.swd391.cvideo_mobile/record");

  int _cvId;
  int _sectionId;
  final SCR008Repository scr008repository;

  int questionSetId;
  int videoStyleId;

  VideoBloc({@required this.scr008repository});

  @override
  VideoState get initialState => VideoStateInitial();

  void setParams(int cvId, int sectionId) {
    this._cvId = cvId;
    this._sectionId = sectionId;
  }

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    if (event is VideoEventQuestionSetChanged) {
      questionSetId = event.questionSetId;
    } else if (event is VideoEventStyleChanged) {
      videoStyleId = event.videoStyleId;
    } else if (event is VideoEventRecorded) {
      yield* _mapVideoRecordedToState(jsonQuestions: event.jsonQuestions);
    } else if (event is VideoEventUploaded) {
      yield VideoStateInitial();
    }
  }

  Stream<VideoState> _mapVideoRecordedToState(
      {@required String jsonQuestions}) async* {
    // Call android native to record video
    try {
      yield VideoStateInitial();

      /// Chekc if [cvId] is null
      if (_cvId == null) {
        print("Video is not belong to any CV.");
        yield VideoStateFailure(errorMsg: "scr008.errMsgCVId");
        return;
      }

      /// Chekc if [cvId] is null
      if (_sectionId == null) {
        print("Video is not belong to any CV's section.");
        yield VideoStateFailure(errorMsg: "scr008.errMsgSectionId");
        return;
      }

      /// Check if [questionSetId] is null
      if (_sectionId == null) {
        print("Can not find the question set template!");
        yield VideoStateFailure(errorMsg: "scr008.errMsgQuestionSetId");
        return;
      }

      /// Inital Publitio
      _configurePublitio();

      /// Get video path from android navitve
      final result = await _platform.invokeMethod("recordVideo", jsonQuestions);

      /// Decode the result after recording video
      dynamic json = jsonDecode(result);
      bool isBackPress = json["isBackPressed"] as bool;

      if (isBackPress) {
        yield VideoStateCancel();
        return;
      }

      final videoPath = json["videoPath"] as String;

      /// Check if [videoPath] is null or empty
      if (videoPath == null || videoPath.isEmpty) {
        print("There no video path");
        yield VideoStateFailure(errorMsg: "scr008.errMsgCommon");
        return;
      }

      /// Video is recorded
      yield VideoStateRecorded();

      /// Uploading video
      yield VideoStateUploading(sectionId: _sectionId);

      /// Update video process
      /// call upload video function
      final response = await _uploadVideo(videoPath);

      http.get(response["url_preview"]);

      ///  get video's width and height
      final width = response["width"];
      final height = response["height"];

      /// compute the video's ratio
      final double aspectRatio = width / height;

      /// Video info
      var videoInfo = VideoInfo(
        cvId: _cvId,
        sectionId: _sectionId,
        styleId: videoStyleId,
        videoUrl: response["url_preview"],
        thumbUrl: response["url_thumbnail"],
        aspectRatio: aspectRatio,
        coverUrl: _getCoverUrl(response),
      );

      /// print video info
      print(videoInfo);

      await scr008repository.postVideoInfo(videoInfo: videoInfo);

      yield VideoStateSuccess();
    } on PlatformException catch (e) {
      print("FAIL TO LOAD RECORD SCREEN: $e");
      yield VideoStateFailure(errorMsg: "scr008.errMsgLoadRecordScreen");
    }
  }

  /// Config Publitio
  _configurePublitio() async {
    await DotEnv().load('assets/publitio/.env');
    await FlutterPublitio.configure(
        DotEnv().env['PUBLITIO_KEY'], DotEnv().env['PUBLITIO_SECRET']);
  }

  // Upload video
  _uploadVideo(videPath) async {
    print('Starting upload................................');
    final uploadOptions = {
      "privacy": "1",
      "option_download": "1",
      "option_transform": "1"
    };
    final response = await FlutterPublitio.uploadFile(videPath, uploadOptions);
    return response;
  }

  // Get thumbnail
  _getCoverUrl(response) {
    final publicId = response["public_id"];
    return "$_PUBLITIO_PREFIX/$publicId.jpg";
  }
}
