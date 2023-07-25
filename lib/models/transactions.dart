// ignore: file_names
class Transactions {
  late int? id;
  String title;
  String author;
  int year;
  String publisher;
  double amount;
  String date;

  Transactions(
      {this.id,
      required this.title,
      required this.author,
      required this.year,
      required this.publisher,
      required this.amount,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'year': year,
      'publisher': publisher,
      'amount': amount,
      'date': date
    };
  }
}
