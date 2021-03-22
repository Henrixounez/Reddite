import 'package:reddite/screens/HomeScreen.dart';
import 'package:reddite/screens/LoginScreen.dart';
import 'package:reddite/screens/PostScreen.dart';
import 'package:reddite/screens/ProfileScreen.dart';
import 'package:reddite/screens/SavedScreen.dart';
import 'package:reddite/screens/SubmissionScreen.dart';

const String homeRoute = '/';
const String loginRoute = '/login';
const String postRoute = '/post';
const String profileRoute = '/profile';
const String savedRoute = '/saved';
const String submissionRoute = '/submission';

Map<String, dynamic> screens = {
  homeRoute: HomeScreen(),
  loginRoute: LoginScreen(),
  postRoute: PostScreen(),
  profileRoute: ProfileScreen(),
  savedRoute: SavedScreen(),
  submissionRoute: SubmissionScreen(),
};
