import 'package:build/build.dart';
import 'package:markdown/markdown.dart';
import 'package:markdown_blog_gen/src/index_builder.dart';
import 'package:markdown_blog_gen/src/layout.dart';

final titleRegExp = RegExp(r'^# (.*)$', multiLine: true);

class HtmlBuilder extends Builder {
  final Layout layout;
  final void Function(Post post) onDetectPost;

  HtmlBuilder({
    required this.layout,
    required this.onDetectPost,
  });

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final path = inputId.path;

    final outputId = AssetId(
      inputId.package,
      path.replaceFirst('lib/', 'web/').replaceFirst('.md', '.html'),
    );

    final content = await buildStep.readAsString(inputId);
    final titleMatch = titleRegExp.firstMatch(content);
    final title = (titleMatch?.group(0) ?? '').replaceFirst('# ', '');
    final contentHtml = markdownToHtml(
      content,
      extensionSet: ExtensionSet.gitHubFlavored,
    );
    final html = layout.generateHtml(
      title,
      contentHtml,
    );
    final post = (
      title: title,
      path: outputId.path.replaceFirst('web/', ''),
    );
    onDetectPost(post);
    await buildStep.writeAsString(outputId, html);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '^lib/blog/{{}}.md': ['web/blog/{{}}.html'],
      };
}
