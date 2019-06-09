import 'package:meta/meta.dart';

class Artist {
  Artist({
    @required this.name,
    @required this.avatar,
    @required this.backdropPhoto,
    @required this.location,
    @required this.biography,
    @required this.videos,
  });

  final String name;
  final String avatar;
  final String backdropPhoto;
  final String location;
  final String biography;
  final List<Video> videos;
}

class Video {
  Video({
    @required this.title,
    @required this.thumbnail,
    @required this.url,
  });

  final String title;
  final String thumbnail;
  final String url;
}

class FakeData {
  static final Artist superfly = Artist(
      name: "Superfly",
      avatar: "assets/avt_superfly.jpg",
      backdropPhoto: "assets/bg_superfly.jpg",
      location: "Japan",
      biography:
      "Superfly is a Japanese rock act that debuted on April 4, 2007.\n"
          " Formerly a duo, the act now consists solely of lyricist and vocalist Shiho Ochi with former guitarist Koichi Tabo still credited as the group's composer and part-time lyricist.\n"
          " Superfly's first two studio albums have been certified double platinum by the Recording Industry Association of Japan, and their first four consecutive albums (the third being classified as a \"single\" by the group)"
          " all debuted at the top of the Oricon's Weekly Album Charts, a first for a female recording artist in Japan in over seven years.",
      videos: <Video>[
        Video(title: "愛をこめて花束を", thumbnail: "http://i3.ytimg.com/vi/gU5oN0KVofU/hqdefault.jpg", url: "https://www.youtube.com/watch?v=gU5oN0KVofU"),
        Video(title: "Beautiful", thumbnail: "http://i3.ytimg.com/vi/tfeSwQ-iU0U/hqdefault.jpg", url: "https://www.youtube.com/watch?v=tfeSwQ-iU0U"),
        Video(title: "輝く月のように", thumbnail: "http://i3.ytimg.com/vi/gG7evVU0OdA/hqdefault.jpg", url: "https://www.youtube.com/watch?v=gG7evVU0OdA"),
      ]);
}