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
    title = data['title'] ?? 'Unknown Title'; // Default value if null
    artist = data['artist'] ?? 'Unknown Artist';
    duration = (data['duration'] != null)
        ? data['duration'].toDouble()
        : 0.0; // Convert to double safely
    releaseDate = (data['release_date'] != null)
        ? DateTime.tryParse(data['release_date']) // Parse safely
        : null; // Keep null if parsing fails
  }
}

//extension to convert song model into song entity
extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title ?? 'Unknown Title', // Fallback if null
      artist: artist ?? 'Unknown Artist',
      duration: duration ?? 0.0,
      releaseDate: releaseDate ?? DateTime.now(), // Use current date if null
    );
  }
}
