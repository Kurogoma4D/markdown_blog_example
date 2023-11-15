import 'package:build/build.dart';
import 'package:markdown_blog_gen/src/html_builder.dart';
import 'package:markdown_blog_gen/src/layout.dart';

Layout layout = Layout();

Builder markdownBlogGen(BuilderOptions options) => HtmlBuilder(
      layout: layout,
    );
