// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
// import 'dart:ffi';

import 'package:badges/badges.dart' as badges;
import 'package:codify100/cart_model.dart';
import 'package:codify100/cart_provider.dart';
import 'package:codify100/cart_screen.dart';
import 'package:codify100/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper? dbHelper = DBHelper();

  List<String> productName = [
    'Arduino Uno',
    'Ultrasonic Sensor',
    'DHT Sensor',
    'Jumper Wires',
    'LEDs',
    'DC Motors',
    'Bread Board'
  ];
  List<String> productUnit = [
    'Piece',
    'Piece',
    'Piece',
    'Pairs',
    'Piece',
    'Piece',
    'piece'
  ];
  List<int> productPrice = [25000, 3000, 2500, 250, 250, 1500, 1000];
  List<String> productImage = [
    'https://upload.wikimedia.org/wikipedia/commons/3/38/Arduino_Uno_-_R3.jpg',
    'https://vayuyaan.com/wp-content/uploads/2021/04/7.jpg',
    'https://www.electronicscomp.com/image/cache/catalog/dht-11-sensor-module-india-800x800.jpg',
    'https://robocraze.com/cdn/shop/products/1_40bbc4ea-ef62-4a1c-a1f7-12434c8bc078.jpg?v=1670580769',
    'https://static.cytron.io/image/cache/catalog/products/V-DS-LED-5N/V-DS-LED-5N%20(a)-800x800.jpg',
    'https://islproducts.com/wp-content/uploads/round-brushless-dc-motor-sideview.jpg',
    'https://cdn-learn.adafruit.com/guides/images/000/001/436/medium800thumb/halfbb_640px.gif'
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 35, 34, 34),
            title: Text(
              "Product List",
              style: TextStyle(color: const Color.fromARGB(255, 219, 219, 219)),
            ),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: Center(
                  child: badges.Badge(
                    badgeContent: Consumer<CartProvider>(
                      builder: (context, value, child) {
                        return Text(value.getCounter().toString(),
                            style: TextStyle(color: Colors.white));
                      },
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: Color.fromARGB(255, 219, 219, 219),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
            ]),
        body: Column(
          
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: productImage.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image(
                                    height: 100,
                                    width: 100,
                                    image: NetworkImage(
                                        productImage[index].toString()),
                                  ),
                                  SizedBox(
                                    height: 5,
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productName[index].toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "IQD ${productPrice[index].toInt()} " +
                                              "a " +
                                              productUnit[index],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              print(index);
                                              print(index);
                                              print(productName[index]
                                                  .toString());
                                              print(productPrice[index]);
                                              print(productPrice[index]
                                                  .toString());
                                              print('1');
                                              print(productUnit[index]
                                                  .toString());
                                              print(productImage[index]
                                                  .toString());
                                              dbHelper!
                                                  .insert(Cart(
                                                id: index,
                                                productId: [index].toString(),
                                                productName: productName[index]
                                                    .toString(),
                                                initialPrice:
                                                    productPrice[index],
                                                productPrice:
                                                    productPrice[index],
                                                quantity: 1,
                                                unitTag: productUnit[index]
                                                    .toString(),
                                                image: productImage[index]
                                                    .toString(),
                                              ))
                                                  .then((value) {
                                                print('product added');
                                                cart.addTotalPrice(double.parse(
                                                    productPrice[index]
                                                        .toString()));
                                                cart.addCounter();
                                              }).onError((error, stackTrace) {
                                                print(error.toString());
                                              });
                                            },
                                            child: Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 51, 167, 55),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: Text(
                                                    "Add to cart",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
