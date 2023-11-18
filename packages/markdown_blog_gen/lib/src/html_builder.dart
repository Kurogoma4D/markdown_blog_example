import 'package:build/build.dart';
import 'package:markdown/markdown.dart';
import 'package:markdown_blog_gen/src/layout.dart';

final titleRegExp = RegExp(r'^# (.*)$', multiLine: true);

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
    final titleMatch = titleRegExp.firstMatch(content);
    final title = titleMatch?.group(0) ?? '';
    final contentHtml = markdownToHtml(
      content,
      extensionSet: ExtensionSet.gitHubFlavored,
    );
    final html = layout.generateHtml(
      title.replaceFirst('# ', ''),
      contentHtml,
    );
    await buildStep.writeAsString(outputId, html);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.md': ['.html'],
      };
}
