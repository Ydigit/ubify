class AppURLs {
  static const coverSupaLink =
    "https://cgkakfyfsmzsheiddmng.supabase.co/storage/v1/object/public/cover-files/";
  static const coverSupaFormat = "_cover.jpg";

  static const songSupaLink =
    "https://cgkakfyfsmzsheiddmng.supabase.co/storage/v1/object/public/music-files/";
  static const songSupaFormat = ".mp3";

  static String getCoverUrl(String title) {
    final formattedTitle = title
        .toLowerCase()
        .replaceAll(" ", "")
        .replaceAll(RegExp(r'[^a-z0-9]'), '');
    return "$coverSupaLink$formattedTitle$coverSupaFormat";
  }

  static String getSongUrl(String title) {
    final formattedTitle = title
        .toLowerCase()
        .replaceAll(" ", "")
        .replaceAll(RegExp(r'[^a-z0-9]'), '');
    return "$songSupaLink$formattedTitle$songSupaFormat";
  }
}