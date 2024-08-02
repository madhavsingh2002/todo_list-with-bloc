import 'package:equatable/equatable.dart';

class ToDo extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;

  ToDo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  ToDo copyWith({String? id, String? title, bool? isCompleted}) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted];
}
