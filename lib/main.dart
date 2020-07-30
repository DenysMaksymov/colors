import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: BlocProvider(
          child: MyHomePage(),
          create: (List) => Bg([0,0,0]),
        )
    );

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color generalColor = Colors.black12;
  int r = 0;
  int g = 0;
  int b = 0;
  void changeGeneralColor(_generalColor){
    setState(() {
      generalColor = Color.fromRGBO(_generalColor[0], _generalColor[1], _generalColor[2], .7);
      r = _generalColor[0];
      g = _generalColor[1];
      b = _generalColor[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<Bg,List>(
        builder: (_, sorse){
          return InkWell(
            splashColor: Color.fromRGBO(sorse[0], sorse[1], sorse[2], .7),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: generalColor,
              child: Center(
                child: Column(
                  children: [
                    Text('COLORS',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.2),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text('R ',style: TextStyle(fontSize: 50),),
                            Text('${r}',style: TextStyle(fontSize: 50),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('G ',style: TextStyle(fontSize: 50),),
                            Text('$g',style: TextStyle(fontSize: 50),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('B ',style: TextStyle(fontSize: 50),),
                            Text('${b}',style: TextStyle(fontSize: 50),),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
              onTap: (){
              context.bloc<Bg>().add(ChangeBgColor.bgColor);
              changeGeneralColor(sorse);
              },
            );
          },
        )
      );
  }
}
enum ChangeBgColor{bgColor}
class Bg extends Bloc<ChangeBgColor, List>{
  Bg(List initialState) : super(initialState);

  @override
  Stream<List> mapEventToState(ChangeBgColor event) async*{
    final random = Random();
    int next() => 0 + random.nextInt(255 - 0);
    var r = next();
    var g = next();
    var b = next();
    List colorRGB = [r,g,b];

    switch (event) {
      case ChangeBgColor.bgColor:
        yield colorRGB;
        break;
    }
  }
}





