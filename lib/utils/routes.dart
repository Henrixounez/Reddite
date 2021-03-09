import 'package:reddite/screens/HomeScreen.dart';
import 'package:reddite/screens/LoginScreen.dart';
import 'package:reddite/screens/PostScreen.dart';

const String homeRoute = '/';
const String loginRoute = '/login';
const String postRoute = '/post';

Map<String, dynamic> screens = {
  homeRoute: HomeScreen(),
  loginRoute: LoginScreen(),
  postRoute: PostScreen(),
};
