import 'package:build/build.dart';
import 'package:markdown_blog_gen/src/html_builder.dart';
import 'package:markdown_blog_gen/src/index_builder.dart';
import 'package:markdown_blog_gen/src/layout.dart';

Layout layout = Layout();

List<Post> posts = <Post>[];

Builder markdownBlogGen(BuilderOptions options) {
  posts = [];
  return HtmlBuilder(
    layout: layout,
    onDetectPost: (post) => posts.add(post),
  );
}

Builder indexBuilder(BuilderOptions options) => IndexBuilder(posts: posts);
