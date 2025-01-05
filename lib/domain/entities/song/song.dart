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
