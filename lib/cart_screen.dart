import 'package:codify100/cart_model.dart';
import 'package:codify100/cart_provider.dart';
import 'package:codify100/db_helper.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper dbHelper = DBHelper();
  CartProvider myCart = CartProvider();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: const Color.fromARGB(255, 203, 203, 203),
            onPressed: () => GoRouter.of(context).go('/')),
        backgroundColor: const Color.fromARGB(255, 35, 34, 34),
        title: const Text(
          "Cart Products",
          style: TextStyle(color: Color.fromARGB(255, 219, 219, 219)),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              dbHelper.clearTable();
              myCart.resetCart();
              showAutomaticSnackbar(context, 'Cart is Empty');
            },
            child: const Center(
              child: Icon(
                Icons.cleaning_services_outlined,
                color: Color.fromARGB(255, 239, 96, 0),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(value.getCounter().toString(),
                      style: const TextStyle(color: Colors.white));
                },
              ),
              animationDuration: const Duration(milliseconds: 300),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Color.fromARGB(255, 219, 219, 219),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image(
                          image: AssetImage('images/empty-cart.png'),
                          height: 450,
                          width: 450,
                          fit: BoxFit.contain,
                        ),
                      ],
                    );
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image(
                                              height: 100,
                                              width: 100,
                                              image: NetworkImage(snapshot
                                                  .data![index].image
                                                  .toString()),
                                            ),
                                            const SizedBox(
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            .productName
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            dbHelper.delete(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!);
                                                            cart.setCounter();
                                                            cart.setTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .productPrice
                                                                    .toString()));
                                                          },
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    203,
                                                                    31,
                                                                    19),
                                                          )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "IQD ${snapshot.data![index].productPrice.toString()} " +
                                                        "a " +
                                                        snapshot.data![index]
                                                            .unitTag
                                                            .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                          height: 35,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  51, 167, 55),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    int quantity = snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity;
                                                                    int price = snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice;
                                                                    quantity--;
                                                                    int?
                                                                        newPrice =
                                                                        price *
                                                                            quantity;

                                                                    if (quantity >=
                                                                        1) {
                                                                      dbHelper
                                                                          .updateQauntity(Cart(
                                                                              id: snapshot.data![index].id,
                                                                              productId: snapshot.data![index].id.toString(),
                                                                              productName: snapshot.data![index].productName.toString(),
                                                                              initialPrice: snapshot.data![index].initialPrice,
                                                                              productPrice: newPrice,
                                                                              quantity: quantity,
                                                                              unitTag: snapshot.data![index].unitTag.toString(),
                                                                              image: snapshot.data![index].image.toString()))
                                                                          .then((value) {
                                                                        newPrice =
                                                                            0;
                                                                        quantity =
                                                                            0;
                                                                        cart.setTotalPrice(double.parse(snapshot
                                                                            .data![index]
                                                                            .initialPrice
                                                                            .toString()));
                                                                      }).onError((error, stackTrace) {
                                                                        print(error
                                                                            .toString());
                                                                      });
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            241,
                                                                            241,
                                                                            241),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    int quantity = snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity;
                                                                    int price = snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice;
                                                                    quantity++;
                                                                    int?
                                                                        newPrice =
                                                                        price *
                                                                            quantity;

                                                                    dbHelper
                                                                        .updateQauntity(Cart(
                                                                            id: snapshot
                                                                                .data![
                                                                                    index]
                                                                                .id,
                                                                            productId: snapshot.data![index].id
                                                                                .toString(),
                                                                            productName: snapshot.data![index].productName
                                                                                .toString(),
                                                                            initialPrice: snapshot
                                                                                .data![
                                                                                    index]
                                                                                .initialPrice,
                                                                            productPrice:
                                                                                newPrice,
                                                                            quantity:
                                                                                quantity,
                                                                            unitTag: snapshot.data![index].unitTag
                                                                                .toString(),
                                                                            image: snapshot.data![index].image
                                                                                .toString()))
                                                                        .then(
                                                                            (value) {
                                                                      newPrice =
                                                                          0;
                                                                      quantity =
                                                                          0;
                                                                      cart.addTotalPrice(double.parse(snapshot
                                                                          .data![
                                                                              index]
                                                                          .initialPrice
                                                                          .toString()));
                                                                    }).onError((error,
                                                                            stackTrace) {
                                                                      print(error
                                                                          .toString());
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .add_circle,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            236,
                                                                            236,
                                                                            236),
                                                                  ),
                                                                ),
                                                              ],
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
                            }));
                  }
                }
                return Text('');
              }),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                  ? false
                  : true,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 43, 43, 43),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ReusableWidget(
                        title: 'Sub Total: ',
                        value:
                            '${value.getTotalPrice().toStringAsFixed(1)} IQD',
                        valueTextColor:
                            const Color.fromARGB(255, 214, 214, 214),
                      ),
                      ReusableWidget(
                        title: 'Discount %10: ',
                        value: '${value.getTotalPrice() * 0.1} IQD',
                        valueTextColor:
                            const Color.fromARGB(255, 214, 214, 214),
                      ),
                      ReusableWidget(
                        title: 'Total: ',
                        value: '${value.getTotalPrice() * 0.9} IQD',
                        valueTextColor:
                            const Color.fromARGB(255, 214, 214, 214),
                      )
                    ],
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  void showAutomaticSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message.toUpperCase()),
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 239, 96, 0),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  final Color? valueTextColor;
  final double borderRadiusTop;
  const ReusableWidget({
    super.key,
    required this.title,
    required this.value,
    this.valueTextColor,
    this.borderRadiusTop = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: valueTextColor),
          ),
          Text(value.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: valueTextColor)),
        ],
      ),
    );
  }
}
