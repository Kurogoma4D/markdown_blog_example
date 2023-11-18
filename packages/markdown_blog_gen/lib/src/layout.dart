import 'package:markdown_blog_gen/src/extension.dart';

class Layout {
  String header(String title) => '''
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../styles.css" />
  <title>$title</title>
</head>
''';

  String generateHtml(String title, String contents) => '''
<!DOCTYPE html>

<html>
${header(title).indented('  ')}
  <body>
${contents.indented('    ')}
  </body>
</html>
''';
}
