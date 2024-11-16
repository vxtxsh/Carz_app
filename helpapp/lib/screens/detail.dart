import 'package:flutter/material.dart';

import '../models/constant.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String brand;
  final String imageUrl;
  final String description;
  final String speed;
  final String seats;
  final String engine;
  final String price;

  const DetailScreen({
    Key? key,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.description,
    required this.speed,
    required this.seats,
    required this.engine,
    required this.price,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: kShadeColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Image.asset('assets/images/back-arrow.png'),
                          ),
                        ),
                      ),

                      // Center(
                      //   child: Padding(
                      //                   padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.start,
                      //                     crossAxisAlignment: CrossAxisAlignment.center,
                      //                     children: [
                      //   //Image.asset(widget.brand),
                      //   //const SizedBox(width: 5),
                      //   Center(child: Text(widget.name, style: kCarTitle)),
                      //                     ],
                      //                   ),
                      //                 ),
                      // ),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(widget.brand),
                      const SizedBox(width: 5),
                      Text(widget.name, style: kCarTitle),
                    ],
                  ),
                ),
                Center(
                  child: Hero(
                    tag: widget.imageUrl,
                    child: Image.asset(widget.imageUrl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 49, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Description', style: kSectionTitle),
                      const SizedBox(height: 10),
                      Text(
                        widget.description,
                        style: kBrand.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Specs', style: kSectionTitle),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/speed.png'),
                              const SizedBox(height: 3),
                              Text(widget.speed, style: kBrand),
                              const SizedBox(height: 3),
                              Text(
                                'Max. Speed',
                                style: kBrand.copyWith(
                                  color: kTextColor.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/seat.png'),
                              const SizedBox(height: 3),
                              Text(widget.seats, style: kBrand),
                              const SizedBox(height: 3),
                              Text(
                                'Seats',
                                style: kBrand.copyWith(
                                  color: kTextColor.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/engine.png'),
                              const SizedBox(height: 3),
                              Text(widget.engine, style: kBrand),
                              const SizedBox(height: 3),
                              Text(
                                'Engine',
                                style: kBrand.copyWith(
                                  color: kTextColor.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 100),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
