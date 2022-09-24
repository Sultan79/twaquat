import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UserDetails extends ChangeNotifier {
  String? id;
  String? name;
  String? email;
  String? image;
  String? firstCountry;
  String? secondCountry;
  String? thirdCountry;
  num? points;
  num? correctGuess;
  num? wrongGuess;
  num? rating;
  UserDetails({
    this.id,
    this.name,
    this.email,
    this.image,
    this.firstCountry,
    this.secondCountry,
    this.thirdCountry,
    this.points,
    this.correctGuess,
    this.wrongGuess,
    this.rating,
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
  }) {
    return UserDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      firstCountry: firstCountry ?? this.firstCountry,
      secondCountry: secondCountry ?? this.secondCountry,
      thirdCountry: thirdCountry ?? this.thirdCountry,
      points: points ?? this.points,
      correctGuess: correctGuess ?? this.correctGuess,
      wrongGuess: wrongGuess ?? this.wrongGuess,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'firstCountry': firstCountry,
      'secondCountry': secondCountry,
      'thirdCountry': thirdCountry,
      'points': points,
      'correctGuess': correctGuess,
      'wrongGuess': wrongGuess,
      'rating': rating,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      image: map['image'],
      firstCountry: map['firstCountry'],
      secondCountry: map['secondCountry'],
      thirdCountry: map['thirdCountry'],
      points: map['points'],
      correctGuess: map['correctGuess'],
      wrongGuess: map['wrongGuess'],
      rating: map['rating'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDetails(id: $id, name: $name, email: $email, image: $image, firstCountry: $firstCountry, secondCountry: $secondCountry, thirdCountry: $thirdCountry, points: $points, correctGuess: $correctGuess, wrongGuess: $wrongGuess, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetails &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.image == image &&
        other.firstCountry == firstCountry &&
        other.secondCountry == secondCountry &&
        other.thirdCountry == thirdCountry &&
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
        firstCountry.hashCode ^
        secondCountry.hashCode ^
        thirdCountry.hashCode ^
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
  }) {

    this.id = id ?? this.id;
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.image = image ?? this.image;
    this.firstCountry = firstCountry ?? this.firstCountry;
    this.secondCountry = secondCountry ?? this.secondCountry;
    this.thirdCountry = thirdCountry ?? this.thirdCountry;
    this.points = points ?? this.points;
    this.correctGuess = correctGuess ?? this.correctGuess;
    this.wrongGuess = wrongGuess ?? this.wrongGuess;
    this.rating = rating ?? this.rating;

    notifyListeners();
  }
}
