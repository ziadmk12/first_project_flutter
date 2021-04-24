import 'package:flutter/material.dart';
import '../pages/macprodetails.dart';

class MacList extends StatelessWidget {
  var price;
  final name;
  final ram;
  final storage;
  final processor;
  final priceUS;
  final priceUK;
  final priceFR;
  final priceMR;
  final country;

  MacList({
    this.name,
    this.ram,
    this.storage,
    this.processor,
    this.price,
    this.priceUS,
    this.priceUK,
    this.priceFR,
    this.priceMR,
    this.country,
  });

  //name: macbooklist[i]['name'],
  // ram: macbooklist[i]['Ram'],
  // storage: macbooklist[i]['Storage'],
  // processor: macbooklist[i]['Processor'],
  // price: macbooklist[i]['Price']);

  Widget build(BuildContext context) {
    if (country == 'Morocco') {
      price = priceMR;
    }
    if (country == 'France') {
      price = priceFR;
    }
    if (country == 'United Kingdom') {
      price = priceUK;
    }
    if (country == 'United States') {
      price = priceUS;
    }
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        height: 150,
        width: 100,
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset('images/categories/mac.jpg'),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    height: 200,
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Ram :',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        ram,
                                        style: TextStyle(color: Colors.purple),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Storage :',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        storage,
                                        style: TextStyle(color: Colors.purple),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Processor :',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        processor,
                                        style: TextStyle(color: Colors.purple),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 100, top: 15),
                          child: Column(
                            children: [
                              Text(
                                'Price : ${price}',
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MacProDetails(
              name1: name,
              ram1: ram,
              storage1: storage,
              processor1: processor,
              price1: price);
        }));
      },
    );
    ;
  }
}
