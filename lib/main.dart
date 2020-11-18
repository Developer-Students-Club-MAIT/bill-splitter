import 'package:flutter/material.dart';

void main() {
  runApp(BillSplitter());
}

class BillSplitter extends StatefulWidget {

  BillSplitter({Key key}) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  int _tipPercentage = 0 ;
  int _personCounter = 1 ;
  double _billAmount = 0.0 ;

  calculatePerPerson(double billAmount,int splitBy,int tipPercentage){
    var finalTip = calculateTotalTip(billAmount, splitBy, tipPercentage) ;
    var totalPerPerson = ( finalTip  + billAmount) / splitBy ;
    return totalPerPerson.toStringAsFixed(2) ;

  }

  calculateTotalTip(double billAmount,int splitBy,int tipPercentage){
    double totalTip = 0.0 ;
    if(billAmount<0){
      print("Bill Amount cannot be negative");
    }else{
      totalTip = (billAmount * tipPercentage)/100 ;
    }
    return totalTip ;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Bill Splitter"),
        ),
        body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green[200].withOpacity(0.7),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Total Per Person",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text( 
                          "\$ ${ calculatePerPerson(_billAmount,_personCounter,_tipPercentage) }",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      maxLength: 9,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                         color: Colors.black,
                         fontSize: 25.0,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter Bill Amount",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        )
                      ),
                      onChanged: (String value){
                        try{
                          _billAmount = double.parse(value);
                        }catch(e){
                          _billAmount = 0.0;
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Split",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(_personCounter>1){
                                    _personCounter--;
                                  }else{
                                    // do nothing
                                  }
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.green[200].withOpacity(0.7),
                                ),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "$_personCounter",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                    _personCounter++;
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.green[200].withOpacity(0.7),
                                ),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Tip",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "\$ ${ calculateTotalTip(_billAmount,_personCounter,_tipPercentage).toStringAsFixed(2) }",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ), 
                    Column(
                      children: <Widget>[
                        Text(
                          "$_tipPercentage%",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        Slider(
                          activeColor: Colors.green[200],
                          inactiveColor: Colors.grey,
                          min: 0,
                          max: 100,
                          divisions: 20,
                          value: _tipPercentage.toDouble(), 
                          onChanged: (double value){
                            setState(() {
                              _tipPercentage = value.round();

                            });
                          },

                        ),
                      ],
                    )       
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


}