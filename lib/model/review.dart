

class Review {
  String? name, review, date;

  Review({this.name, this.date, this.review});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      date: json['date'],
      name: json['name'],
      review: json['review'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'date': date,
      'name': name,
      'review': review,
    };
  }
}
