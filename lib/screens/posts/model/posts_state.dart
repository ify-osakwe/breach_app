import 'package:breach/data/models/post_entity.dart';
import 'package:equatable/equatable.dart';

class PostsState extends Equatable {
  final bool isLoading;
  final List<PostEntity> postsList;

  const PostsState({required this.isLoading, required this.postsList});

  PostsState copyWith({
    bool? isLoading,
    List<PostEntity>? postsList,
    bool? isEmptyInterest,
  }) {
    return PostsState(
      isLoading: isLoading ?? this.isLoading,
      postsList: postsList ?? this.postsList,
    );
  }

  @override
  List<Object?> get props => [isLoading, postsList];
}
