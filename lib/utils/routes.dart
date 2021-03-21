import 'package:reddite/screens/HomeScreen.dart';
import 'package:reddite/screens/LoginScreen.dart';
import 'package:reddite/screens/PostScreen.dart';
import 'package:reddite/screens/ProfileScreen.dart';

const String homeRoute = '/';
const String loginRoute = '/login';
const String postRoute = '/post';
const String profileRoute = '/profile';

Map<String, dynamic> screens = {
  homeRoute: HomeScreen(),
  loginRoute: LoginScreen(),
  postRoute: PostScreen(),
  profileRoute: ProfileScreen(),
};
