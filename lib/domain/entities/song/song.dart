//bem
//U:\Mobile\Project\ubify\lib\domain\entities\song\song.dart
class SongEntity {
  String title;
  String artist;
  double duration; // Para o campo float4
  DateTime releaseDate; // Para o campo date

  SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });
}
