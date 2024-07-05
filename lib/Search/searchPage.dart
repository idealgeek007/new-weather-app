import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:weather_app/Utils/SizeConfig.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;
  List<String> recentCities = [];
  var width = SizeConfig.screenWidth;
  final Box<String> recentCitiesBox = Hive.box<String>('recentCitiesBox');

  @override
  void initState() {
    super.initState();
    _loadRecentCities();
  }

  void _loadRecentCities() {
    setState(() {
      recentCities = recentCitiesBox.values.toList();
    });
    print('Loaded recent cities: $recentCities');
  }

  void _saveRecentCity(String city) {
    if (!recentCities.contains(city)) {
      recentCitiesBox.add(city);
      setState(() {
        recentCities.add(city);
      });
    }
    print('Saved recent cities: $recentCities');
  }

  void _deleteRecentCity(int index) {
    recentCitiesBox.deleteAt(index);
    setState(() {
      recentCities.removeAt(index);
    });
    print('Deleted city at index $index');
  }

  void _clearAllRecentCities() {
    recentCitiesBox.clear();
    setState(() {
      recentCities.clear();
    });
    print('Cleared all recent cities');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Color(0xFFACCCFD),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: width * 0.01,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Bootstrap.arrow_left_short,
                    size: width * 0.1,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter City',
                    icon: Icon(
                      Bootstrap.map,
                      color: Colors.black87,
                      size: width * 0.08,
                    ),
                    hintStyle: GoogleFonts.poppins(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  cursorColor: Colors.blue,
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              Container(
                width: width * 0.9,
                height: width * 0.13,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      offset: Offset(3, 5),
                      blurRadius: 50,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.inner,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    if (cityName != null && cityName!.isNotEmpty) {
                      _saveRecentCity(cityName!);
                      Navigator.pop(context, cityName);
                    }
                  },
                  child: Text(
                    'GET WEATHER',
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Recent Searches',
                style: GoogleFonts.poppins(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              recentCities.isNotEmpty
                  ? TextButton(
                      onPressed: _clearAllRecentCities,
                      child: Text(
                        'Clear All',
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                        ),
                      ),
                    )
                  : Container(),
              Expanded(
                child: recentCities.isEmpty
                    ? Center(
                        child: Text(
                          'No recent searches',
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: recentCities.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.5),
                                    offset: Offset(3, 5),
                                    blurRadius: 50,
                                    spreadRadius: 3,
                                    blurStyle: BlurStyle.inner,
                                  ),
                                ],
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                /*  gradient: LinearGradient(
                                  colors: [
                                    Colors.blue[100]!,
                                    Colors.blue[300]!
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),*/
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    recentCities[index],
                                    style: GoogleFonts.poppins(
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete_outlined),
                                    color: Colors.black45,
                                    onPressed: () {
                                      _deleteRecentCity(index);
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.pop(context, recentCities[index]);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
