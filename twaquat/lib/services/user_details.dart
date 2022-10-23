import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UserDetails extends ChangeNotifier {
  String? id;
  String? name;
  String? email;
  String? image;
  String? myCuntry;
  String? firstWinner;
  String? secondWinner;
  List? quizzes;
  num? points;
  num? correctGuess;
  num? wrongGuess;
  num? rank;
  bool isAdmin;
  UserDetails({
    this.id,
    this.name,
    this.email,
    this.image,
    this.myCuntry,
    this.firstWinner,
    this.secondWinner,
    this.points,
    this.correctGuess,
    this.wrongGuess,
    this.rank,
    this.quizzes,
    this.isAdmin = false,
  });

  UserDetails copyWith({
    String? id,
    String? name,
    String? email,
    String? image,
    String? firstCountry,
    String? secondCountry,
    String? thirdCountry,
    num? points,
    num? correctGuess,
    num? wrongGuess,
    num? rating,
    List? quizzes,
    bool? isAdmin,
  }) {
    return UserDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      myCuntry: firstCountry ?? this.myCuntry,
      firstWinner: secondCountry ?? this.firstWinner,
      secondWinner: thirdCountry ?? this.secondWinner,
      points: points ?? this.points,
      correctGuess: correctGuess ?? this.correctGuess,
      wrongGuess: wrongGuess ?? this.wrongGuess,
      rank: rating ?? this.rank,
      quizzes: quizzes ?? this.quizzes,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'firstCountry': myCuntry,
      'secondCountry': firstWinner,
      'thirdCountry': secondWinner,
      'points': points,
      'correctGuess': correctGuess,
      'wrongGuess': wrongGuess,
      'rating': rank,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      image: map['image'],
      myCuntry: map['firstCountry'],
      firstWinner: map['secondCountry'],
      secondWinner: map['thirdCountry'],
      points: map['points'],
      correctGuess: map['correctGuess'],
      wrongGuess: map['wrongGuess'],
      rank: map['rating'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDetails(id: $id, name: $name, email: $email, image: $image, firstCountry: $myCuntry, secondCountry: $firstWinner, thirdCountry: $secondWinner, points: $points, correctGuess: $correctGuess, wrongGuess: $wrongGuess, rating: $rank)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetails &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.image == image &&
        other.myCuntry == myCuntry &&
        other.firstWinner == firstWinner &&
        other.secondWinner == secondWinner &&
        other.points == points &&
        other.correctGuess == correctGuess &&
        other.wrongGuess == wrongGuess &&
        other.rank == rank;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        image.hashCode ^
        myCuntry.hashCode ^
        firstWinner.hashCode ^
        secondWinner.hashCode ^
        points.hashCode ^
        correctGuess.hashCode ^
        wrongGuess.hashCode ^
        rank.hashCode;
  }

  void setUserData({
    String? id,
    String? name,
    String? email,
    String? image,
    String? firstCountry,
    String? secondCountry,
    String? thirdCountry,
    num? points,
    num? correctGuess,
    num? wrongGuess,
    num? rating,
    List? quizzes,
    bool? isAdmin,
  }) {
    this.id = id ?? this.id;
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.image = image ?? this.image;
    this.myCuntry = firstCountry ?? this.myCuntry;
    this.firstWinner = secondCountry ?? this.firstWinner;
    this.secondWinner = thirdCountry ?? this.secondWinner;
    this.points = points ?? this.points;
    this.correctGuess = correctGuess ?? this.correctGuess;
    this.wrongGuess = wrongGuess ?? this.wrongGuess;
    this.rank = rating ?? this.rank;
    this.quizzes = quizzes ?? this.quizzes;
    this.isAdmin = isAdmin ?? this.isAdmin;

    notifyListeners();
  }

  setUserRank(int rank) {
    this.rank = rank;
    notifyListeners();
  }
}
