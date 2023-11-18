extension StringEx on String {
  String indented(String indent) =>
      split('\n').map((e) => '$indent$e').join('\n');
}
