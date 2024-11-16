
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:helpapp/screens/all_news.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../additives/bottom_bar.dart';
import '../additives/floating_button.dart';
import '../models/constant.dart';
import '../models/brand.dart';
import '../models/car.dart';
import '../models/article_model.dart';
import '../models/category_model.dart';
import '../models/data.dart';
import '../models/event_display.dart';
import '../models/news.dart';
import '../models/slider_model.dart';
import 'detail.dart';
import 'rented.dart';
import 'slider_data.dart';

class EventModel {
  final int eventId;
  final String name;
  final String date;
  final String startTime;
  final String endTime;
  final VenueModel venue;
  final String description;
  final EventTypeModel type;
  final ContactModel contact;
  final ClubModel club;
  final String? image;

  EventModel(
      {required this.eventId,
      required this.name,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.venue,
      required this.description,
      required this.type,
      required this.contact,
      required this.club,
      required this.image});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['eventId'],
      name: json['name'],
      date: _parseDate(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      venue: VenueModel.fromJson(json['venue']),
      description: json['description'],
      type: EventTypeModel.fromJson(json['type']),
      contact: ContactModel.fromJson(json['contact']),
      club: ClubModel.fromJson(json['club']),
      image: json['image'],
    );
  }

  static String _parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      final formattedDate =
          '${parts[2]}-${parts[0].padLeft(2, '0')}-${parts[1].padLeft(2, '0')}';
      return formattedDate;
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
  }

  DateTime getDateTime() {
    try {
      return DateTime.parse(date);
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now();
    }
  }
}

class VenueModel {
  final int venueId;
  final String venueName;

  VenueModel({required this.venueId, required this.venueName});

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      venueId: json['venueId'],
      venueName: json['venueName'],
    );
  }
}

class EventTypeModel {
  final int contactId;
  final String name;
  final String email;
  final String phone;

  EventTypeModel(
      {required this.contactId,
      required this.name,
      required this.email,
      required this.phone});

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(
      contactId: json['contactId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class ContactModel {
  final int contactId;
  final String name;
  final String email;
  final String phone;

  ContactModel(
      {required this.contactId,
      required this.name,
      required this.email,
      required this.phone});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      contactId: json['contactId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class ClubModel {
  final int clubId;
  final String clubName;
  final String clubDescription;
  final String clubContact;

  ClubModel(
      {required this.clubId,
      required this.clubName,
      required this.clubDescription,
      required this.clubContact});

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
      clubId: json['clubId'],
      clubName: json['clubName'],
      clubDescription: json['clubDescription'],
      clubContact: json['clubContact'],
    );
  }
}

class EventService {
  final String baseUrl = 'http://192.168.1.6:8080';

  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events/'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<EventModel>((event) => EventModel.fromJson(event))
          .toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  late Future<List<EventModel>> futureEvents;
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true,loading2=true;

  int activeIndex = 0;
  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
    //super.initState();
    futureEvents = EventService().fetchEvents();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

    getSlider() async {
    Sliders slider= Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
  setState(() {
    loading2=false;
  });
  }

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime currentDate = DateTime.now();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Brands>(create: (context) => Brands()),
        ChangeNotifierProvider<Cars>(create: (context) => Cars()),
      ],
      child: Scaffold(
        bottomNavigationBar: const CustomBottomNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const MyFloatingActionButton(),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                height: size.height * 0.07,
                width: size.width,
                margin: const EdgeInsets.fromLTRB(15, 20, 16, 24),
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 14),
                decoration: BoxDecoration(
                  color: kShadeColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search for Car...',
                    hintStyle: kSearchHint,
                    icon: Image.asset('assets/images/search.png'),
                  ),
                ),
              ),

              SizedBox(
                          height: 20.0,
                        ),
              
              Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " Latest Car News",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: "Breaking")));
                                },
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                      //decoration: TextDecoration.underline,
                                      decorationColor: Colors.blue,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      loading2? Center(child: CircularProgressIndicator()):  CarouselSlider.builder(
                            itemCount: 5,
                            itemBuilder: (context, index, realIndex) {
                              String? res = sliders[index].urlToImage;
                              String? res1 = sliders[index].title;
                              return buildImage(res!, index, res1!);
                            },
                            options: CarouselOptions(
                                height: 200,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.height,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    activeIndex = index;
                                  });
                                })),


              Padding(
                padding: const EdgeInsets.fromLTRB(15, 24, 15, 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular',
                      style: kSectionTitle,
                    ),
                    Consumer<Cars>(
                      builder: (context, item, _) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RecentlyRented(
                                item: item,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'View all',
                          style: kViewAll,
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
              Consumer<Cars>(
                builder: (context, item, _) => SizedBox(
                  height: size.height * 0.25,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: item.cars.length,
                    itemBuilder: (ctx, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                name: item.cars[i].name,
                                brand: item.cars[i].brand,
                                imageUrl: item.cars[i].imageUrl,
                                description: item.cars[i].description,
                                speed: item.cars[i].speed,
                                seats: item.cars[i].seats,
                                engine: item.cars[i].engine,
                                price: item.cars[i].price,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: size.height * 0.3,
                          width: size.width * 0.5,
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          padding: const EdgeInsets.fromLTRB(12, 16, 12, 11),
                          decoration: BoxDecoration(
                            color: kShadeColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.cars[i].name,
                                        style: kBrand,
                                      ),
                                      const SizedBox(height: 4),
                                      
                                    ],
                                  ),
                                  
                                ],
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Hero(
                                  tag: item.cars[i].imageUrl,
                                  child: Image.asset(
                                    item.cars[i].imageUrl,
                                    scale: 1.5,
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
                  
                  FutureBuilder<List<EventModel>>(
                    future: futureEvents,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Failed to load events'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No events available'));
                      } else {
                        List<EventModel> upcomingEvents = snapshot.data!
                            .where((event) => eventIsUpcoming(event, currentDate))
                            .toList();
                        return EventSection(
                          title: 'Your Cars',
                          events: upcomingEvents,
                        );
                      }
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }

bool eventIsUpcoming(EventModel event, DateTime currentDate) {
    DateTime eventDate = event.getDateTime();
    DateTime eventEndDate = eventDate.add(Duration(days: 365));
    return eventDate.isBefore(currentDate) || eventEndDate.isAfter(currentDate);
  }




Widget buildImage(String image, int index, String name) => Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
      
            height: 150,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width, imageUrl: image,
          ),
        ),
        Container(
          height: 150,
          padding: EdgeInsets.only(left: 10.0),
          margin: EdgeInsets.only(top: 130.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Padding( 
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                name,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ]));

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: SlideEffect(
            dotWidth: 10, dotHeight: 10, activeDotColor: Colors.purple),
      );
}

class EventSection extends StatelessWidget {
  final String title;
  final List<EventModel> events;

  EventSection({required this.title, required this.events});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          padding: const EdgeInsets.fromLTRB(12, 16, 12, 11),
                          decoration: BoxDecoration(
                            color: kShadeColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventCard(event: events[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventModel event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              eventName: event.name,
              eventImage: event.image != null
                  ? Image.memory(
                      base64Decode(event.image!),
                      height: 125,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/TECHNICAL.png',
                      height: 125,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
              eventDescription: event.description,
              eventDate: event.date,
              eventVenue: event.venue.venueName,
              eventTime: '${event.startTime} - ${event.endTime}',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              
              BoxShadow(
                color: Color.fromARGB(255, 35, 35, 35),
                offset: Offset(7.0, 7.0),
                blurRadius: 17,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Container(
            width: 275,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              color: Color.fromARGB(255, 68, 72, 84),
              
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 32, 32, 32),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: event.image != null
                                ? Image.memory(
                                    base64Decode(event.image!),
                                    height: 125,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/TECHNICAL.png',
                                    height: 125,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        event.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(event.description,style: TextStyle(
                          fontSize: 8,
                          //fontWeight: FontWeight.bold,
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
