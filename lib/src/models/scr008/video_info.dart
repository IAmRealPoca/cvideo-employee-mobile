import 'package:meta/meta.dart';

class VideoInfo {
  final int cvId;
  final int sectionId;
  final int styleId;
  final String videoUrl;
  final String thumbUrl;
  final String coverUrl;
  final double aspectRatio;

  VideoInfo({
    @required this.cvId,
    @required this.sectionId,
    @required this.styleId,
    @required this.videoUrl,
    @required this.thumbUrl,
    @required this.coverUrl,
    @required this.aspectRatio,
  });

  Map<String, Object> toJson() {
    return {
      "styleId": styleId,
      "sectionId": sectionId,
      "videoUrl": videoUrl,
      "thumbUrl": thumbUrl,
      "aspectRatio": aspectRatio,
      "coverUrl": coverUrl,
    };
  }

  @override
  String toString() {
    return "VideoInfo: {cvId: $cvId, sectionId: $sectionId, styleId: $styleId, videoUrl: $videoUrl, thumbUrl: $thumbUrl, coverUrl: $coverUrl, aspectRatio: $aspectRatio }";
  }
}
