// ignore_for_file: constant_identifier_names

class SourceInfo {
  static const int GROUP_TYPE = 1;
  static const int INDIVIDUAL_TYPE = 0;
  final String name;
  final String id;
  //type = group or individual
  final int type;
  const SourceInfo({this.name = "", this.id = "", this.type = INDIVIDUAL_TYPE});
}

// ignore: camel_case_types
enum REACTION_TYPE {
  LIKE_REACTION,
  LOVE_REACTION,
  HAHA_REACTION,
  CARE_REACTION,
  WOW_REACTION,
  SORRY_REACTION,
  ANGRY_REACTION,
}

class Reaction {
  final REACTION_TYPE type;
  final int count;
  const Reaction({this.type = REACTION_TYPE.LIKE_REACTION, this.count = 0});
}

class Post {
  final String idPost;

  final SourceInfo from;
  final SourceInfo to;
  final String caption;
  final List<String> images;
  final List<String> videos;
  final List<Reaction> reacts;
  final String date_time;
  const Post(
      {this.idPost = '',
      this.from = const SourceInfo(),
      this.to = const SourceInfo(),
      this.caption = '',
      this.images = const [],
      this.videos = const [],
      this.reacts = const [],
      this.date_time = ''});
}

var samplePosts = [
  Post(idPost: '0000001', from: SourceInfo()),
];
