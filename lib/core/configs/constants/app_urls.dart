class AppURLs {
  static const coverSupaLink =
      "https://cgkakfyfsmzsheiddmng.supabase.co/storage/v1/object/public/cover-files/";
  static const coverSupaFormat = "_cover.jpg";

  static String getCoverUrl(String title) {
    final formattedTitle = title
        .toLowerCase()
        .replaceAll(" ", "")
        .replaceAll(RegExp(r'[^a-z0-9]'), '');
    return "$coverSupaLink$formattedTitle$coverSupaFormat";
  }
}
