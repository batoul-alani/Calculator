import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String equation='0';
  String result='0';
  String op='';
  double equationFontSize=38.0;
  double resultFontSize=48.0;

  buttonPressed(String childy){
    setState(() {
      switch(childy){
        case 'C':
          equation='0';
          result='0';
          equationFontSize=38.0;
          resultFontSize=48.0;
          break;
        case '⌫':
          equationFontSize=48.0;
          resultFontSize=38.0;
          equation=equation.substring(0,equation.length-1);
          if(equation==''){
            equation='0';
          }
          break;
        case 'Ac':
          equation='0';
          break;
        case '=':
          equationFontSize=38.0;
          resultFontSize=48.0;

          op=equation;
          op=op.replaceAll('X', '*');
          op=op.replaceAll('/', '/');

          try{
            Parser p=Parser(); //l 7ta 3ref almo3adlat  b ast5dam al symbol
            Expression exp=p.parse(op); //ast5dmt al op b3d ma holth

            ContextModel cm=ContextModel();
            result='${exp.evaluate(EvaluationType.REAL, cm)}';
          }
          catch(e){
            result='Error';
          }
          break;
        default:
          equationFontSize=48.0;
          resultFontSize=38.0;
          if(equation=='0'){ equation=childy; }
          else{ equation=equation+childy; }
      }
    });
  }

  Widget buttonTable(Color colour,String childy) {
    return Container(
      height: 50.1,
      color: colour,
      child: TextButton(
        onPressed: (){
          setState(() {
            buttonPressed(childy);
          });
        },
        child: Text(
          childy,style: TextStyle(
          fontSize: 30.0,
          color: Colors.white54,
          fontFamily: 'STIXTwoMath',
        ),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            'Simple Calculator',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[

            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                  color: Colors.white54,
                ),
                child: Text(equation,style: TextStyle(
                  fontSize: equationFontSize,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),

            Expanded(child: Divider(),),

            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                  color: Colors.white54,
                ),
                child: Text(result.toString(),style: TextStyle(
                  fontSize: resultFontSize,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Table(

                    children: [
                      TableRow(
                          children: [

                            buttonTable(Colors.red, 'C', ),
                            buttonTable(Colors.lightBlueAccent, '⌫',),
                            buttonTable(Colors.lightBlueAccent,  '-',),
                            buttonTable(Colors.lightBlueAccent, 'Ac',),
                          ]
                      ),

                      TableRow(
                          children: [
                            buttonTable(Colors.blueGrey, '7',),
                            buttonTable(Colors.blueGrey, '8',),
                            buttonTable(Colors.blueGrey, '9',),
                            buttonTable(Colors.lightBlueAccent, 'X',),
                          ]
                      ),

                      TableRow(
                          children: [
                            buttonTable(Colors.blueGrey,  '4',),
                            buttonTable(Colors.blueGrey, '5',),
                            buttonTable(Colors.blueGrey,  '6',),
                            buttonTable(Colors.red,  '/',),
                          ]
                      ),

                      TableRow(
                          children: [
                            buttonTable( Colors.blueGrey, '1',),
                            buttonTable( Colors.blueGrey, '2',),
                            buttonTable( Colors.blueGrey, '3',),
                            buttonTable( Colors.red,  '+',),
                          ]
                      ),

                      TableRow(
                          children: [
                            buttonTable( Colors.blueGrey,  '.',),
                            buttonTable( Colors.blueGrey,  '0',),
                            buttonTable( Colors.blueGrey,  '00',),
                            buttonTable( Colors.red,  '=',),
                          ]
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


