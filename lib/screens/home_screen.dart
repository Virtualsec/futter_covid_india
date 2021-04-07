import 'dart:developer';

import 'package:covid_india/models/data_modal.dart';
import 'package:covid_india/providers/stats_providers.dart';
import 'package:covid_india/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<StatsProviders>(context).fetchData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Data> data = Provider.of<StatsProviders>(context).getData;
    var formatter = NumberFormat('#,##,000');
    TextStyle tableText = TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: kDarkColor,
    );

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
              text: 'Covid '.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: 'India',
                  style: TextStyle(color: kPrimaryColor),
                )
              ]),
        ),
      ),
      body: SafeArea(
        child: data.length == 0
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: kLightColor,
                  strokeWidth: 3.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    kPrimaryColor,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      // Container(
                      //   width: double.infinity,
                      //   margin: EdgeInsets.symmetric(horizontal: 24),
                      //   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4),
                      //     color: Color(0xfff6f6f7),
                      //   ),
                      //   child: TextField(
                      //     decoration: new InputDecoration.collapsed(
                      //       hintText: "Search your district or state",
                      //       hintStyle: TextStyle(
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 16),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                StatsCard(
                                  title: 'Confirmed',
                                  value:
                                      '${formatter.format(int.parse(data[0].confirmed))}',
                                  textColor: kRedColor,
                                  bgColor: kRedLightColor,
                                ),
                                SizedBox(width: 16),
                                StatsCard(
                                  title: 'Active',
                                  value:
                                      '${formatter.format(int.parse(data[0].confirmed))}',
                                  textColor: kBlueColor,
                                  bgColor: kBlueLightColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                StatsCard(
                                  title: 'Recovered',
                                  value:
                                      '${formatter.format(int.parse(data[0].recovered))}',
                                  textColor: kGreenColor,
                                  bgColor: kGreenLightColor,
                                ),
                                SizedBox(width: 16),
                                StatsCard(
                                  title: 'Deceased',
                                  value:
                                      '${formatter.format(int.parse(data[0].deaths))}',
                                  textColor: kOrangeColor,
                                  bgColor: kOrangeLightColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 24),
                            DataTable(
                              headingRowColor:
                                  MaterialStateProperty.all(kLightColor),
                              headingRowHeight: 46,
                              horizontalMargin: 20,
                              headingTextStyle: TextStyle(
                                color: kDarkColor,
                                fontFamily: 'Nunito',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              columns: [
                                DataColumn(
                                  label: Text('State/UT'),
                                ),
                                DataColumn(
                                  label: Text('Confirmed'),
                                ),
                                DataColumn(
                                  label: Text('Active'),
                                ),
                                DataColumn(
                                  label: Text('Recovered'),
                                ),
                                DataColumn(
                                  label: Text('Deceased'),
                                ),
                              ],
                              rows: [
                                for (int i = 1; i <= data.length - 1; i++)
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                        Container(
                                          width: 120,
                                          child: Text(
                                            '${data[i].state}',
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: kDarkColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(
                                        '${formatter.format(int.parse(data[i].confirmed))}',
                                        style: tableText,
                                      )),
                                      DataCell(Text(
                                        '${formatter.format(int.parse(data[i].active))}',
                                        style: tableText,
                                      )),
                                      DataCell(Text(
                                        '${formatter.format(int.parse(data[i].recovered))}',
                                        style: tableText,
                                      )),
                                      DataCell(Text(
                                        '${formatter.format(int.parse(data[i].deaths))}',
                                        style: tableText,
                                      )),
                                    ],
                                  ),
                              ],
                            ),
                            SizedBox(width: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color bgColor;
  final Color textColor;

  const StatsCard({
    Key key,
    this.title,
    this.value,
    this.bgColor,
    this.textColor,
  });

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: bgColor,
        ),
        child: Column(
          children: [
            Text(
              '$title'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '$value',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
