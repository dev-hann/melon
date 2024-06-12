import 'package:equatable/equatable.dart';

class MelonDj extends Equatable {
  MelonDj({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.tagList,
  });

  final String id;
  final String title;
  final String imageURL;
  final List<String> tagList;

  @override
  List<Object?> get props => [
        id,
        title,
        imageURL,
        tagList,
      ];
}
