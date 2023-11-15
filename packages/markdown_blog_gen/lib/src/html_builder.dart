import 'package:build/build.dart';
import 'package:markdown/markdown.dart';
import 'package:markdown_blog_gen/src/layout.dart';

class HtmlBuilder extends Builder {
  final Layout layout;

  HtmlBuilder({required this.layout});

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final path = inputId.path;
    if (!path.contains('web/blog/')) {
      return;
    }

    final outputId = inputId.changeExtension('.html');

    final content = await buildStep.readAsString(inputId);
    final contentHtml = markdownToHtml(content);
    final html = layout.generateHtml(contentHtml);
    await buildStep.writeAsString(outputId, html);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.md': ['.html'],
      };
}
