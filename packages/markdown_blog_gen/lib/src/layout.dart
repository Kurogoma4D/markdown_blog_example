class Layout {
  final String header = '''
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>kurogoma_blog</title>
    <link rel="stylesheet" href="styles.css" />
</head>
''';

  String generateHtml(String contents) => '''
<!DOCTYPE html>

<html>
  $header
  <body>
    $contents
  </body>
</html>
''';
}
