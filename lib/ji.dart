import 'package:flutter/material.dart';


import 'package:pie_chart/pie_chart.dart';

class Data {
  double d1;
  double d2;

  Data({this.d1,this.d2});
}
class calcii extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return calciistate();
  }
}

///Crafting the UI
class calciistate extends State<calcii> {
  final _formKey = GlobalKey<FormState>();
  final _padding = EdgeInsets.all(18.0);
  final _currencies = ['Rupees', 'Dollar'];
  var selectedItem = ' ';
  var principalController = TextEditingController();
  var interestController = TextEditingController();
  var periodController = TextEditingController();
  var displayResullt = '';
  final data1 = Data(
    d1: 0,
    d2: 0,
  );

  @override
  void initState()
  {
    super.initState();
    selectedItem = _currencies[0];

  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Interest Calculator',
        ),

      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              height: 35.0,
            ),

            getAmountField(
              'Enter Principal Amount',
              'Principals (P)',
              Icons.attach_money,
              principalController,
              _padding,
            ),
            getAmountField(
              'Enter in Percentage (%)',
              'Interest Rate (R)',
              Icons.payment,
              interestController,
              _padding,
            ),
            Padding(
              padding: _padding,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: getAmountField(
                      'Enter yrs',
                      'Term Length',
                      Icons.access_time,
                      periodController,
                      EdgeInsets.all(0),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: DropdownButton<String>(
                        value: selectedItem,
                        items: _currencies.map(
                              (String dropItems) => DropdownMenuItem<String>(
                            value: dropItems,
                            child: Text(dropItems),
                          ),
                        )
                            .toList(),
                        onChanged: (String selectedItem) =>
                            selectMethod(selectedItem),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: _padding,
              child: Row(
                children: <Widget>[
                  getCalcButton('Reset Values', Colors.lightGreen, reset),
                  Container(
                    width: 60.0,
                  ),
                  getCalcButton('Calculate SI', Colors.orangeAccent, calculate),
                ],
              ),
            ),
            Padding(
              padding: _padding,
              child: Center(
                child: Text(
                  displayResullt,
                  style: TextStyle(fontWeight: FontWeight.w800, fontStyle: FontStyle.italic, color: Colors.brown.withOpacity(0.9), height: 2, fontSize: 18),
                ),
              ),
            ),
          ],
        ),

      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () =>
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>MyHomePage(data1:data1)))
        },
        child: Icon(Icons.insert_chart),
      ),
    );
  }

  /// Crafting the TextFormField
  Widget getAmountField(String hintText, String labelText, IconData iconOfField,
      TextEditingController textController, EdgeInsets wrapp)
  {
    return Container(
      child: Padding(
        padding: wrapp,
        child: TextFormField
          (
          validator: (String input) {
            if (input.isEmpty) return 'Invalid Entry!!!';
          },
          controller: textController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorStyle: TextStyle
              (
              color: Colors.red,
              fontSize: 15.0,
            ),
            prefixIcon: Icon(iconOfField),
            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
      ),
    );
  }

  ///Crafting the Button
  Widget getCalcButton(
      String buttonName, Color buttonColor, Function buttonFunc) {
    return Expanded(
      child: RaisedButton(
        child: Text(
          buttonName,
        ),
        color: buttonColor,
        onPressed: () => setState
          (
              () {
            if (_formKey.currentState.validate())
              this.displayResullt = buttonFunc();
          },
        ),
      ),
    );
  }

  /// User Selection Method
  void selectMethod(String selectedItem) {
    setState(() => this.selectedItem = selectedItem);
  }

  /// Button Calculate Method
  String calculate() {
    var principal = double.parse(principalController.text);
    var interest = double.parse(interestController.text);
    var period = double.parse(periodController.text);
    var totalAmmount = principal + (principal * interest * period) / 100;
    var onlyinterest= totalAmmount- principal;
    var result = 'Total Amount (with interest) for $principal $selectedItem after $period years at $interest% interest rate is :\t  $totalAmmount  $selectedItem.';
var gy = '$totalAmmount';
    data1.d1 = principal + (principal * interest * period) / 100;
    data1.d2 = totalAmmount- principal;
    return result;


  }


  ///Button Reset Method
  String reset() {
    principalController.text = '';
    interestController.text = '';
    periodController.text = '';
    displayResullt = '';
    selectedItem = _currencies[0];
    return '';
  }
}

class MyHomePage extends StatefulWidget {
  final Data data1;

  MyHomePage({this.data1});

  @override
  _MyHomePageState createState() => _MyHomePageState(this.data1);
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, double> data = new Map();
  bool _loadChart = false;
  Data data1;
  @override
  _MyHomePageState(this.data1);
  void initState() {
    data.addAll({
      'Flutter': data1.d1,
      'React Native': data1.d2,
    });
    super.initState();
  }

  List<Color> _colors = [
    Colors.redAccent,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interest v/s Principal'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              'Extra Amount over the Principal Amount',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25,color:Colors.green, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 60,
            ),
            _loadChart ? PieChart(
              dataMap: data,
              colorList:_colors, // if not declared, random colors will be chosen
              animationDuration: Duration(milliseconds: 4000),
              chartLegendSpacing: 25.0,
              chartRadius: MediaQuery.of(context).size.width /0.7, //determines the size of the chart
              showChartValuesInPercentage: true,
              showChartValues: true,
              showLegends: true,
              legendPosition:LegendPosition.right, //can be changed to top, left, bottom
              decimalPlaces: 1,
              initialAngle: 90,
              chartValueStyle: defaultChartValueStyle.copyWith(
                  color: Colors.white, fontSize: 16
              ),
              chartType: ChartType.disc, //can be changed to ChartType.ring
            ) : SizedBox( height: 270,
            ),
            SizedBox(
              height: 115,
            ),
            RaisedButton(
              color: Colors.blueAccent,
              child: Text('Click Here for Pie Chart Representation', style: TextStyle(color: Colors.white, fontSize: 15,
              ),),
              onPressed: () {
                setState(() {
                  _loadChart = true;
                });
              },

            ),
          ],
        ),
      ),
    );
  }
}