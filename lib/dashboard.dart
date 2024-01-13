import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webnox/DataModel/products.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:like_button/like_button.dart';
import 'package:flutter/services.dart';
import 'Dummy_screen/sample_screen.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  //textformfield
  TextEditingController search_ctr = TextEditingController();
  int msg = 28;
  int notification = 9;
  //Products Array
  List<String> imagePaths = [];
  List<String> icons_img = [];
  @override
  void initState() {
    // TODO: implement initState
    fetchProducts();
    imagePaths = [
      'assets/icons/shirt_1.png',
      'assets/icons/shirt_2.png',
      'assets/icons/t-shirt.png',
      'assets/icons/shirt_4.png',
      'assets/icons/black_coat.png',
      'assets/icons/shirt_1.png',
      'assets/icons/shirt_2.png',
      'assets/icons/t-shirt.png',
      'assets/icons/shirt_4.png',
      'assets/icons/black_coat.png',
    ];

    icons_img = [
      'assets/icons/category.png',
      'assets/icons/jet.png',
      'assets/icons/bill.png',
      'assets/icons/network.png',
      'assets/icons/topup.png',
    ];
    super.initState();
  }

  List<String> icon_title = [
    "Category",
    "Flight",
    "Bill",
    "Data Plan",
    "Top Up",
  ];
//Api get Method
  List<Product> productList = [];

  Future<void> fetchProducts() async {
    productList.clear();

    final response = await http.get(Uri.parse(
        'https://dummyjson.com/products?limit=10&skip=10&select=title,price'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('jsonData is $jsonData');

      for (var item in jsonData['products']) {
        productList.add(Product.fromJson(item));
      }
      setState(() {
        productList = productList;
      });
      print('productList is ${productList.length}');
      // print('${productList[0].id} ${productList[0].price}');
    } else {
      throw Exception('Failed to load products');
    }
  }

//like button
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

//search
  Color search_color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Are you sure you want to exit?',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home_rounded,
                        color: Color.fromARGB(202, 5, 112, 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => sample_screen(),
                            ));
                      },
                    ),
                    Text('Home',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(201, 0, 0, 0),
                            fontSize: 11)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.airplane_ticket,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => sample_screen(),
                            ));
                      },
                    ),
                    Text('Voucher',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 11)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.wallet,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => sample_screen(),
                            ));
                      },
                    ),
                    Text('Wallet',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 11)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => sample_screen(),
                            ));
                      },
                    ),
                    Text(
                      'Settings',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 244, 244, 244),
        body: RefreshIndicator(
          onRefresh: () => fetchProducts(),
          child: SafeArea(
            child: Stack(children: [
              SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 65.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 0.5,
                      height: 130,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 244, 244, 244),
                        Color.fromARGB(255, 173, 218, 255),
                      ])),
                      child: CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context, index, realIndex) {
                            var currentIndex = 0;
                            return Stack(children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "# Fashion Day",
                                            style: GoogleFonts.poppins(
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "80% OFF",
                                            style: GoogleFonts.montserrat(
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 33),
                                          ),
                                          Text(
                                            "Discover Fashion that suits to \nyour style",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 107, 103, 103),
                                                fontSize: 10),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                // fetchProducts();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 37, 34, 34),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                6))),
                                                width: 90,
                                                height: 25,
                                                child: Center(
                                                  child: Text(
                                                    "Check this out",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              width: 160,
                                              fit: BoxFit.fill,
                                              "assets/icons/tshirt_banner.png",
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: index == 0
                                            ? Colors.black
                                            : Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: index == 1
                                            ? Colors.black
                                            : Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(3),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: index == 2
                                            ? Colors.black
                                            : Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ]),
                            ]);
                          },
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: 200,
                            autoPlay: true,
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            viewportFraction: 1,

                            //enableInfiniteScroll: false,
                          )),
                    ),
                  ),
                  Container(
                    color: Color.fromARGB(255, 240, 254, 255),
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: icon_title.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 11.0, right: 11.0, top: 13),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 231, 231, 231),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                                width: 50,
                                height: 50,
                                child: Center(
                                    child: Image.asset(
                                  "${icons_img[index].toString()}",
                                  height: 30,
                                  width: 30,
                                )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "${icon_title[index].toString()}",
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 138, 136, 136),
                                    fontSize: 11),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 244, 244, 244),
                      Color.fromARGB(255, 173, 218, 255)
                    ])),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Best Sale Product",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 16),
                              ),
                              Text("See more..",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 111, 48),
                                      fontSize: 12))
                            ],
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height + 110,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 244, 244, 244),
                              Color.fromARGB(255, 173, 218, 255)
                            ])),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: productList.length > 0
                                ? GridView.builder(
                                    addAutomaticKeepAlives: true,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    // Enable GridView's scroll physics
                                    shrinkWrap: true,
                                    itemCount: productList.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 30.0,
                                            crossAxisSpacing: 20.0,
                                            childAspectRatio: 1.0,
                                            mainAxisExtent: 200),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 80,
                                        width: 150,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          shadows: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 0, 208, 255),
                                              blurRadius: 4,
                                              offset: Offset(2, 2),
                                              spreadRadius: 0,
                                            ),
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  135, 255, 81, 81),
                                              blurRadius: 9,
                                              offset: Offset(1, 3),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 3),
                                                width: 170,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 237, 233, 233),
                                                ),
                                                child: Image.asset(
                                                    imagePaths[index]
                                                        .toString()),
                                              ),
                                              Positioned(
                                                left: 120,
                                                child: LikeButton(
                                                  size: 26,
                                                  onTap: onLikeButtonTapped,
                                                ),
                                              ),
                                            ]),
                                            Row(
                                              //Color.fromARGB(255, 237, 233, 233),
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    "Shirt",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 52,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0),
                                                      child: Text(
                                                          '${productList[index].title.toString()}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3.0),
                                                      child: Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      "4.9 | 2356 ",
                                                      style:
                                                          GoogleFonts.sansita(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 1.0),
                                                  child: Text(
                                                    "Rs.${productList[index].price}/-",
                                                    style: GoogleFonts.sansita(
                                                      fontSize: 14,
                                                      color: Color.fromARGB(
                                                          255, 0, 111, 48),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(255, 255, 0, 170),
                                    ),
                                  )),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ]),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 244, 244, 244),
                    Color.fromARGB(255, 173, 218, 255)
                  ])),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              border: Border.all(color: search_color)),
                          child: Row(children: [
                            Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  "assets/icons/search.png",
                                )),
                            Container(
                              // color: Colors.red,
                              height: 40,
                              width: MediaQuery.of(context).size.width / 2 + 15,
                              child: TextFormField(
                                enableSuggestions: true,
                                maxLines: 2,
                                validator: (value) {},
                                controller: search_ctr,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search.."),
                              ),
                            )
                          ]),
                        ),
                      ),
                      Stack(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => sample_screen(),
                                        ));
                                  },
                                  child: Container(
                                      // color: Colors.blue,
                                      width: 50,
                                      height: 50,
                                      child: Image.asset(
                                        "assets/icons/bag.png",
                                      )),
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => sample_screen(),
                                      )),
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    // color: Colors.amber,
                                    width: 50,
                                    height: 50,
                                    child: Image.asset("assets/icons/chat.png"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 25,
                          left: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                            ),
                            // width: 15,
                            // height: 15,
                            child: Padding(
                              padding: const EdgeInsets.all(1.5),
                              child: Center(
                                child: Text("$msg",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 25,
                          left: 83,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                            ),
                            // width: 15,
                            // height: 15,
                            child: Padding(
                              padding: const EdgeInsets.all(1.5),
                              child: Center(
                                child: Text("${notification}+",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white)),
                              ),
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
