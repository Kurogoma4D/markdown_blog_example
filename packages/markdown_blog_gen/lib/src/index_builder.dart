import 'dart:async';

import 'package:build/build.dart';
import 'package:markdown_blog_gen/src/extension.dart';

typedef Post = ({String title, String path});

class IndexBuilder extends Builder {
  final List<Post> posts;

  IndexBuilder({required this.posts});

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final path = inputId.path;
    if (path != 'lib/index.html') {
      return;
    }

    final contents = await buildStep.readAsString(inputId);
    final outputId = AssetId(
      inputId.package,
      'web/index.html',
    );
    final postsHtml = posts.map((post) => '''
<li>
  <a href="${post.path}">${post.title}</a>
</li>
''').join('\n');
    final html = contents.replaceFirst(
      '    {{ pages }}',
      '<ul id="posts">\n$postsHtml\n</ul>'.indented('    '),
    );
    await buildStep.writeAsString(outputId, html);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '^lib/{{}}.html': ['web/{{}}.html']
      };
}
