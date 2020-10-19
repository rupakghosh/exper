import 'package:flutter/material.dart';

import 'ji2.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIC',
      theme: ThemeData(

        primarySwatch: Colors.purple,

      ),
      home: MyHomePage(title: 'Simple Interest'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '   ~Interest calculated on the Principal portion of the original contribuition to savings account',
              style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.normal, color: Colors.blueGrey.withOpacity(0.9), height: 2, fontSize: 18),
            ),
            new Text(
              '\n   ~Account holder will only gain interest on the principal',
                style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.normal, color: Colors.blueGrey.withOpacity(0.9), height: 2, fontSize: 18),
            ),
            new Text(
              '\n   ~Reffered to as Total payable or gainable amount over a fixed principal after certain time att the specified interest rate',
              style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.normal, color: Colors.blueGrey.withOpacity(0.9), height: 2, fontSize: 18),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton
        (
        onPressed: () =>
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>calcii ()))
        },
        child: Icon(Icons.add_box),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
