//U:\Mobile\Project\ubify\lib\data\models\song\song.dart
import 'package:ubify/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  double? duration; // Para o campo float4
  DateTime? releaseDate; // Para o campo date

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
  }
}

//extension to convert song model into song entity
extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
        title: title!,
        artist: artist!,
        duration: duration!,
        releaseDate: releaseDate!);
  }
}
