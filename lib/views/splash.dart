import 'package:flutter/material.dart';
class SplashPage extends StatefulWidget{
  SplashState createState()=>SplashState();
}

class SplashState extends State{
  Widget build(BuildContext context){
    return Container(
      child:new Image.asset('assets/start.jpg',width: double.infinity,height: double.infinity,),
    );
  }
}