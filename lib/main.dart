import 'package:crypto_tracker/screens/screens.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var textSize = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto App',
      theme: ThemeData.dark().copyWith(
        textTheme: textSize.copyWith(
          headline4: textSize.headline4!.copyWith(
            color: Colors.white,
          ),
          headline5: textSize.headline5!.copyWith(
            fontWeight: FontWeight.bold,

            color: Colors.white,
          ),
          headline6: textSize.headline6!.copyWith(
            color: Colors.white,
          ),
          subtitle1: textSize.subtitle1!.copyWith(
            color: Colors.white,
          ),
          subtitle2: textSize.subtitle2!.copyWith(
            color: Colors.white,
          ),
          overline:  textSize.overline!.copyWith(color: Colors.blue),
        )
      ),
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}