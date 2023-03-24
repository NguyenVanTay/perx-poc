import 'dart:async';
import 'dart:convert';
import 'package:dogs_park/pages/daycarePackages_page/components/time_option.dart';

import 'package:dogs_park/theme/dimens.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../theme/colors.dart';
import '../../widgets/text_style.dart';
import 'package:http/http.dart' as http;

class DaycarePackagePickupReturn extends StatefulWidget {
  const DaycarePackagePickupReturn({Key? key}) : super(key: key);

  @override
  State<DaycarePackagePickupReturn> createState() =>
      _DaycarePackagePickupReturnState();
}

class _DaycarePackagePickupReturnState
    extends State<DaycarePackagePickupReturn> {
  final todaysDate = DateTime.now();
  DateTime? _selectedCalendarDate;
  var currentDateSelected = {
    'datetime': '',
    'time': '10:00Am',
  };

  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  int _selectedTimeIndex = -1;
  final RxDouble lat = 0.0.obs;
  final RxDouble log = 0.0.obs;
  DateTime? selectedCalendarDate;
  final TextEditingController _searchController = TextEditingController();
  //TODO: Load time options
  var timeOptions = [
    {"time": "10:00 AM", "canChoose": true, "isSelected": false},
    {"time": "11:00 AM", "canChoose": true, "isSelected": false},
    {"time": "12:00 AM", "canChoose": false, "isSelected": false},
    {"time": "01:00 PM", "canChoose": true, "isSelected": false},
    {"time": "02:00 PM", "canChoose": true, "isSelected": false},
    {"time": "03:00 PM", "canChoose": true, "isSelected": false},
    {"time": "04:00 PM", "canChoose": true, "isSelected": false},
    {"time": "05:00 PM", "canChoose": true, "isSelected": false},
    {"time": "06:00 PM", "canChoose": true, "isSelected": false}
  ];
  final Completer<GoogleMapController> _controller = Completer();

  // ignore: prefer_const_declarations
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(10.7816346, 106.6811739),
    zoom: 14.4746,
  );
  final Marker _kGooglePlexMarker = const Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: "1C Innovation"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(10.7816346, 106.6811739));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCalendarDate = _focusedCalendarDate;
    currentDateSelected['datetime'] = _focusedCalendarDate.toString();
  }

  late WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    // print(agrumentList);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back(result: []);
          },
          color: AppColors.black,
        ),
        actions: [
          IconButton(
            color: AppColors.black,
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
            iconSize: 30,
          )
        ],
        elevation: 0.0,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 37),
                child: Text('Pick up/Return',
                    style: AppTextStyle.daycarePackagesText),
              ),
              TableCalendar(
                pageJumpingEnabled: true,
                eventLoader: (day) {
                  if (currentDateSelected['datetime'].toString() != '') {
                    var current = DateTime.tryParse(
                        currentDateSelected['datetime'].toString());
                    if (current!.day == day.day &&
                        current.month == day.month &&
                        current.year == day.year) return ['Cyclic Event'];
                  }
                  return [];
                },
                firstDay: _initialCalendarDate,
                lastDay: _lastCalendarDate,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedCalendarDate!, day);
                },
                focusedDay: _focusedCalendarDate,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedCalendarDate, selectedDay)) {
                    setState(() {
                      _selectedCalendarDate = selectedDay;
                      currentDateSelected['datetime'] = selectedDay.toString();
                      _focusedCalendarDate = focusedDay;
                    });
                  }
                },
                headerStyle: const HeaderStyle(
                  headerMargin: EdgeInsets.only(left: 21.0, bottom: 13.0),
                  titleTextStyle: AppTextStyle.titleCalendar,
                  leftChevronVisible: true,
                  rightChevronVisible: true,
                  formatButtonVisible: false,
                ),
                calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle),
                    markerDecoration: BoxDecoration(
                        color: AppColors.red, shape: BoxShape.circle)),
                startingDayOfWeek: StartingDayOfWeek.sunday,
                daysOfWeekStyle: DaysOfWeekStyle(
                  dowTextFormatter: (date, locale) =>
                      DateFormat.E(locale).format(date)[0],
                  weekendStyle: AppTextStyle.weekendStyle,
                  weekdayStyle: AppTextStyle.weekdayStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: Text(
                  'Time',
                  style: AppTextStyle.daycareHeader,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...Iterable<int>.generate(timeOptions.length).map(
                    (index) => TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.all(0.0)),
                      onPressed: () {
                        setState(() {
                          if (index != _selectedTimeIndex) {
                            timeOptions[index]['isSelected'] =
                                !(timeOptions[index]['isSelected'].toString() ==
                                    'true');
                            currentDateSelected['time'] =
                                timeOptions[index]['time'].toString();
                            if (_selectedTimeIndex != -1) {
                              timeOptions[_selectedTimeIndex]['isSelected'] =
                                  false;
                            }
                            _selectedTimeIndex = index;
                          }
                        });
                      },
                      child: TimeOption(
                        time: timeOptions[index]['time'].toString(),
                        canChoose: timeOptions[index]['canChoose'].toString() ==
                            'true',
                        isSelected:
                            timeOptions[index]['isSelected'].toString() ==
                                'true',
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 36, bottom: 9),
                child: Text(
                  'Location',
                  style: AppTextStyle.daycareHeader,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFEBEBEB),
                          spreadRadius: 1,
                          offset: Offset(1, 2)),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    controller: _searchController,
                    textCapitalization: TextCapitalization.words,
                    style: AppTextStyle.daycareTextField1,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '...',
                        hintStyle: AppTextStyle.titleSmall),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Text('or search on map'),
              )
            ],
          ),
        ),
        SizedBox(
            height: 600,
            child: WebView(
              initialUrl: 'https://www.google.com/maps',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) => webViewController = controller,
              onPageFinished: (url) {
                String decodeURI = Uri.decodeFull(url).toString();
                //check if find locarion
                print(decodeURI);
                String decodeURL = getLocationFromMapURL(decodeURI);
                print(decodeURL);
                if (decodeURL.contains('google') == false) {
                  if (_searchController.text == "https://www.google.com/maps") {
                    _searchController.text = " ";
                  } else {
                    _searchController.text = decodeURL;
                    setState(() {});
                  }
                }
              },
            )),
        Container(
          // ignore: sort_child_properties_last
          child: TextButton(
              onPressed: () {
                if (_searchController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(Dimens.pleaseLocation)));
                } else {
                  Get.back(
                      result: [currentDateSelected, _searchController.text]);
                }
              },
              child: Text(
                'Next',
                style: AppTextStyle.daycareConfirmInfo1
                    .copyWith(color: Colors.white),
              )),
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
              color: Color(0xFF04CEBC),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ]),
    );
  }

  static String getLocationFromMapURL(String mapURL) {
    //strip before search
    if (mapURL.contains('/search/')) {
      mapURL = mapURL.substring(mapURL.indexOf('/search/') + '/search/'.length);
    }
    if (mapURL.contains('/place/')) {
      mapURL = mapURL.substring(mapURL.indexOf('/place/') + '/place/'.length);
    }
    //strip coordinate
    mapURL = mapURL.substring(0, mapURL.indexOf("/@"));

    //replace '+' = ' '
    return mapURL.replaceAll('+', ' ');
  }
}
