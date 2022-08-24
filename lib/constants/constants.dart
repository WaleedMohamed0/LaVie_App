import 'package:flutter/material.dart';
import 'package:life/models/posts_model.dart';
import 'package:life/models/profile_model.dart';
import 'package:life/models/quiz_model.dart';

import '../models/notification_model.dart';
import '../models/products_model.dart';
String baseUrl = "https://lavie.orangedigitalcenteregypt.com/api/v1/";
const Color defaultColor = Color(0xff1ABC00);
const Color transparentColor = Colors.transparent;
String token = "";
String baseUrlForImage = "https://lavie.orangedigitalcenteregypt.com";
List<ProductsData> allProducts = [];
List<int> productsQuantity = [];

List<NotificationModel> notificationList = [
  NotificationModel(
      imageUrl: 'assets/images/Joy.png',
      title: 'Joy Arnold left 6 comments on Your Post',
      time: 'Yesterday at 11:42 PM'),
  NotificationModel(
      imageUrl: 'assets/images/Dennis.png',
      title: 'Dennis Nedry commented on Isla Nublar SOC2 compliance report',
      text:
          "“ leaves are an integral part of the stem system. They are attached by a continuous vascular system to the rest of the plant so that free exchange of nutrients.”",
      time: 'Yesterday at 5:42 PM'),
  NotificationModel(
      imageUrl: 'assets/images/John.png',
      title: 'John Hammond created Isla Nublar SOC2 compliance report  ',
      time: 'Wednesday at 11:15 AM'),
];

List<QuizModel> quizList = [
  QuizModel(
      question: 'What is the user experience?',
      questionAnswers: [
        'The user experience is how the developer feels about a user.',
        'The user experience is how the user feels about interacting with or experiencing a product.',
        'The user experience is the attitude the UX designer has about a product.',
      ],
      correctAnswer: 1),
  QuizModel(
      question: 'Which of the following is not a programming language?',
      questionAnswers: [
        'TypeScript',
        'Python',
        'Anaconda',
      ],
      correctAnswer: 2),
  QuizModel(
      question: 'Python is _____ programming language.',
      questionAnswers: ['high-level', 'mid-level', 'low-level'],
      correctAnswer: 0)
];
bool timeForQuiz = false;
