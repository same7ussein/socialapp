import 'package:facebook_clone/layout/cubit/states.dart';
import 'package:facebook_clone/shared/BlocObserver.dart';
import 'package:facebook_clone/shared/Network/local/sharedPreferences.dart';
import 'package:facebook_clone/shared/styles/Themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/cubit.dart';
import 'layout/socialLayout.dart';
import 'modules/LoginScreen/login_screen.dart';

void main() async {
  late Widget widget;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
  if (CacheHelper.getData(key: 'uId') != null&&CacheHelper.getData(key: 'uId') !='') {
    widget = HomeScreen();
  } else
    widget = LoginScreen();
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SocialCubit()..getUserData()
    ),
        ],
        child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: startWidget);
          },
        ));
  }
}
