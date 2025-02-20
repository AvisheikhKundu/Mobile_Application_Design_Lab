class Book {
  String title;
  String author;

  Book(this.title, this.author);

  void displayInfo() {
    print('Title: Nam er ki dorkar, Author: Okobi Avisheikh');
  }
}

void main() {
  Book book1 = Book("NAM er ki dorkar", "Okobi Avisheikh");
  book1.displayInfo();
}