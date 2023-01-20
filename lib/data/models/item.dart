class Item {
  final int id;
  final String title;
  final String description;
  bool done;

  Item(
      {required this.id,
      required this.title,
      this.description = "",
      this.done = false});
}
