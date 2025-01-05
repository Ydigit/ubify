class AppURLs {
  static const coverBigLink =
      "https://cgkakfyfsmzsheiddmng.supabase.co/storage/v1/object/public/cover-files/beware_cover.jpg";
  static const coverSupaLink =
      "https://cgkakfyfsmzsheiddmng.supabase.co/storage/v1/object/public/cover-files/";
  //In the middle is the song name
  static const coverSupaFormat = "_cover.jpg";

  static String getCoverUrl(String title) {
    final formattedTitle = title
        .toLowerCase()
        .replaceAll(" ", "")
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    return "$coverSupaLink$formattedTitle$coverSupaFormat";
  }
}
