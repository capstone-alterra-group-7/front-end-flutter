// ignore_for_file: avoid_print

import 'package:capstone_project_tripease/features_kai/view/ka_page/widgets/history_search.dart';
import 'package:capstone_project_tripease/features_kai/view/ka_page/widgets/not_found_station.dart';
import 'package:capstone_project_tripease/features_kai/view_model/station/history_station_provider.dart';
import 'package:capstone_project_tripease/features_kai/view_model/station/station_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.isOrigin});
  final bool isOrigin;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isTextFieldActive = false;
  List<dynamic> allStation = [];
  List<dynamic> foundStation = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    _textFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final stationProv = Provider.of<StationProvider>(context, listen: false);
    final historyStationProv =
        Provider.of<HistoryStationProvider>(context, listen: false);
    historyStationProv.fetchHistoryStation();
    stationProv.getSearchStation();
    foundStation = allStation;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = allStation;
    } else {
      results = allStation
          .where((stationName) => stationName["name"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundStation = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final stationProv = Provider.of<StationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 128, 255, 1),
        title: Text(
          widget.isOrigin == true
              ? 'Pencarian Stasiun Asal'
              : 'Pencarian Stasiun Tujuan',
          style: GoogleFonts.openSans(
              fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(double.maxFinite, 78.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            color: const Color.fromRGBO(0, 128, 255, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(),
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.only(right: 16, top: 10.h, bottom: 10),
                    hintText: 'Ketuk untuk cari stasiun',
                    hintStyle: GoogleFonts.openSans(
                      fontSize: 14.sp,
                      color: const Color.fromRGBO(150, 152, 156, 1),
                    ),
                    prefix: SizedBox(width: 12.w),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color.fromRGBO(150, 152, 156, 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Color.fromRGBO(210, 215, 224, 1)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Color.fromRGBO(210, 215, 224, 1)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      allStation = stationProv.allStation;
                      isTextFieldActive = true;
                    });
                  },
                  onChanged: (value) {
                    _runFilter(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            width: double.maxFinite,
            height: 700.h,
            color: Colors.grey.shade100,
            child: ListView(
              children: [
                _searchController.text.isNotEmpty
                    ? foundStation.isNotEmpty
                        ? SizedBox(
                            height: 500.h,
                            child: ListView.builder(
                              itemCount: foundStation.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    var params = foundStation[index];

                                    if (widget.isOrigin) {
                                      print('Origin');
                                      stationProv
                                          .setIdOrigin(params["station_id"]);
                                      stationProv.setNameOrigin(params["name"]);
                                      stationProv
                                          .setInitialOrigin(params["initial"]);
                                      print('id : ${stationProv.getIdOrigin}');
                                      print(
                                          'Name :${stationProv.getNameOrigin}');
                                      print(
                                          'init : ${stationProv.getInitialOrigin}');

                                      stationProv.setAsalController(
                                          '${stationProv.getNameOrigin!} (${stationProv.getInitialOrigin!})');
                                      Navigator.pop(context);
                                    } else {
                                      print('Destination');
                                      stationProv.setIdDestination(
                                          params["station_id"]);
                                      stationProv
                                          .setNameDestination(params["name"]);
                                      stationProv.setInitialDestination(
                                          params["initial"]);
                                      print(
                                          'id : ${stationProv.getIdDestination}');
                                      print(
                                          'Name :${stationProv.getNameDestination}');
                                      print(
                                          'init : ${stationProv.getInitialDestination}');
                                      stationProv.setTujuanController(
                                          '${stationProv.getNameDestination!} (${stationProv.getInitialDestination!})');
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w,
                                            right: 20.w,
                                            top: 15.h,
                                            bottom: 15.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  foundStation[index]["name"]
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(width: 8.h),
                                                Container(
                                                  width: 5,
                                                  height: 5,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(width: 8.h),
                                                Text(
                                                  foundStation[index]["initial"]
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              foundStation[index]["origin"]
                                                  .toString(),
                                              style: GoogleFonts.openSans(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black54,
                                        height: 7.h,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : NotFoundStation(
                            value: _searchController.text,
                          )
                    : Padding(
                        padding: EdgeInsets.all(20.w),
                        child: HistorySearch(isOrigin: widget.isOrigin),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
