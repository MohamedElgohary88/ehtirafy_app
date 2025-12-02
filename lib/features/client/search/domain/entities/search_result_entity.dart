import 'package:equatable/equatable.dart';

class SearchResultEntity extends Equatable {
  final String id;
  final String title;
  final String type; // 'recent', 'popular', 'result'

  const SearchResultEntity({
    required this.id,
    required this.title,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, type];
}
