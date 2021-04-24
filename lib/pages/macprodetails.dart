import 'package:flutter/material.dart';

class MacProDetails extends StatefulWidget {
  @override
  final name1;
  final ram1;
  final storage1;
  final processor1;
  final price1;

  MacProDetails(
      {this.name1, this.ram1, this.storage1, this.processor1, this.price1});

  _MacProDetailsState createState() => _MacProDetailsState();
}

class _MacProDetailsState extends State<MacProDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Details',
            style: TextStyle(color: Colors.yellowAccent),
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: ListView(
          children: [
            Container(
              height: 300,
              child: GridTile(
                child: Image.asset('images/categories/mac.jpg'),
                footer: Container(
                    color: Colors.black.withOpacity(0.3),
                    height: 40,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            widget.name1,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        )),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            widget.price1,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(
                'Specifiction ',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                color: Colors.purple,
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Ram :', style: TextStyle(fontSize: 20)),
                    TextSpan(text: widget.ram1, style: TextStyle(fontSize: 20))
                  ]),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text('Storage :', style: TextStyle(fontSize: 20)),
                    Text(widget.storage1, style: TextStyle(fontSize: 20)),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(20),
                color: Colors.purple,
                child: Row(
                  children: [
                    Text('Processor :',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    Text(widget.processor1,
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                )),

            // Container(
            //   child: Column(children: [
            //     mySpec(context,'Name : ', widget.name1,Colors.purple,Colors.white);
            //     mySpec(context,'Ram : ', widget.ram1,Colors.purple,Colors.white);
            //     mySpec(context,'Storage : ', widget.storage1,Colors.purple,Colors.white);
            //     mySpec(context,'Processor : ', widget.processor1,Colors.purple,Colors.white);
            //     mySpec(context,'Price : ', widget.price1,Colors.purple,Colors.white);
            //   ],),
            // )
          ],
        ));
  }
}
