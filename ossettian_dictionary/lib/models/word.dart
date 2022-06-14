class Word {
  int? id;
  String? osettianTranslate;
  List<String>? russianTranslates;
  String? transcription;
  bool? isFavorite;

  Word(
      {this.id,
      this.osettianTranslate,
      this.russianTranslates,
      this.transcription,
      this.isFavorite = false});
}
