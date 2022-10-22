import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
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
  num? rating;
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
    this.rating,
    this.quizzes,
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
      rating: rating ?? this.rating,
      quizzes: quizzes ?? this.quizzes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id'.tr(): id,
      'name'.tr(): name,
      'email'.tr(): email,
      'image'.tr(): image,
      'firstCountry'.tr(): myCuntry,
      'secondCountry'.tr(): firstWinner,
      'thirdCountry'.tr(): secondWinner,
      'points'.tr(): points,
      'correctGuess'.tr(): correctGuess,
      'wrongGuess'.tr(): wrongGuess,
      'rating'.tr(): rating,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id'.tr()],
      name: map['name'.tr()],
      email: map['email'.tr()],
      image: map['image'.tr()],
      myCuntry: map['firstCountry'.tr()],
      firstWinner: map['secondCountry'.tr()],
      secondWinner: map['thirdCountry'.tr()],
      points: map['points'.tr()],
      correctGuess: map['correctGuess'.tr()],
      wrongGuess: map['wrongGuess'.tr()],
      rating: map['rating'.tr()],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDetails(id: $id, name: $name, email: $email, image: $image, firstCountry: $myCuntry, secondCountry: $firstWinner, thirdCountry: $secondWinner, points: $points, correctGuess: $correctGuess, wrongGuess: $wrongGuess, rating: $rating)';
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
        other.rating == rating;
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
        rating.hashCode;
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
    this.rating = rating ?? this.rating;
    this.quizzes = quizzes ?? this.quizzes;

    notifyListeners();
  }
}
