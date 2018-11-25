import 'package:flutter/material.dart';
class RegisterPage extends StatefulWidget{

  RegisterState createState()=>RegisterState();
}
class RegisterState extends State<RegisterPage>{
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text('注册'),centerTitle: true,),
      body: new Container(
        child: new Form(

            child: new TextFormField(

            )
        ),
      ),
    );
  }
}
