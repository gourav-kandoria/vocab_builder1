class Word {
  String value;
  List<String> collections;
  List<String> sentences;
  Word(this.value, this.sentences);

  factory Word.fromJson(Map<String,dynamic> json) {
    if(json==null) return null ;
    return Word(json["value"], 
                json["sentences"]);
  }
}