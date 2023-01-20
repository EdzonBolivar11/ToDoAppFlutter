import 'package:to_do_app/data/models/item.dart';

class ListItems {
  final List<Item> incompleted;
  final List<Item> completed;

  ListItems({this.incompleted = const [], this.completed = const []});

  static List<Item> todoIncompletedList() => [
        Item(
          id: 1,
          title: "Upload 1099-R to TurboTax",
          description: "💰 Finance",
        ),
        Item(
          id: 2,
          title: "Submit 2019 tax return",
          description: "💰 Finance",
        ),
        Item(
          id: 3,
          title: "Print parking passes",
          description: "💞 Wedding",
        ),
        Item(
          id: 4,
          title: "Sign contract, send back",
          description: "🖥 Freelance",
        ),
        Item(
          id: 5,
          title: "Hand sanitizer",
          description: "🛒 Shopping List",
        ),
      ];

  static List<Item> todoCompletedList() => [
        Item(
            id: 1,
            title: "Upload 1099-R to TurboTax",
            description: "💰 Finance",
            done: true),
        Item(
            id: 2,
            title: "Submit 2019 tax return",
            description: "💰 Finance",
            done: true),
        Item(
            id: 3,
            title: "Print parking passes",
            description: "💞 Wedding",
            done: true),
        Item(
            id: 4,
            title: "Sign contract, send back",
            description: "🖥 Freelance",
            done: true),
        Item(
            id: 5,
            title: "Hand sanitizer",
            description: "🛒 Shopping List",
            done: true),
      ];
}
