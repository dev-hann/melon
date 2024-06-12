import 'package:equatable/equatable.dart';

class MelonSong extends Equatable {
  const MelonSong({
    required this.rank,
    required this.song,
    required this.album,
    required this.imageURL,
    required this.singer,
  });

  final int rank;
  final String singer;
  final String song;
  final String album;
  final String imageURL;

  String get query {
    return "$song $singer audio";
  }

  @override
  List<Object?> get props => [
        rank,
        song,
        album,
        imageURL,
        singer,
      ];
}
