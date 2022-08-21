abstract class PostsStates{}
class PostsInitialState extends PostsStates{}


class GetPostsLoadingState extends PostsStates{}
class GetPostsSuccessState extends PostsStates{}
class GetPostsErrorState extends PostsStates{}

class ForumsSuccessState extends PostsStates{}
class GotImagePathSuccessState extends PostsStates{}

class AddPostLoadingState extends PostsStates{}
class AddPostSuccessState extends PostsStates{}
class AddPostErrorState extends PostsStates{}

class SearchPostsSuccessState extends PostsStates{}