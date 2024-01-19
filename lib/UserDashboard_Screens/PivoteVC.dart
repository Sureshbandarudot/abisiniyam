
import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/ApartDshbrdModel.dart';
import 'package:tourstravels/UserDashboard_Screens/Apartbooking_Model.dart';
//import 'NewUserbooking.dart';
class PivotDashboard extends StatefulWidget {
  const PivotDashboard({super.key});

  @override
  State<PivotDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<PivotDashboard> {

  String bookings = '';
  int Bookable_iD = 0;
  String status = '';
  int idnum = 0;
  String Date = '';
  int selectedIndex = 0;
  int imageID = 0;
  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  var getbookingData = [];
  var startDateList = [];
  var endDateList = [];
  String startDatestr = '';
  String endDatestr = '';
  var pivotsts = '';
  String Retrivedcityvalue = '';
  String RetrivedAdress = '';
  var controller = ScrollController();
  late Future<List<DashboardApart>> BookingDashboardUsers ;
  int count = 15;
 // late Future<List<Apart>> listUsers ;
  late Future<List<Pivot>> BookinguserList ;

  List<Pivot> welcomeFromJson(String str) => List<Pivot>.from(json.decode(str).map((x) => Pivot.fromJSON(x)));
  String welcomeToJson(List<Pivot> data) => json.encode(List<dynamic>.from(data.map((x) => x.toString())));
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      Bookable_iD = prefs.getInt('userbookingId') ?? 0;
      Retrivedcityvalue = prefs.getString('citykey') ?? "";
      RetrivedAdress = prefs.getString('addresskey') ?? "";




    });
  }
//@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    //getData();

  }
  Future<dynamic> getData() async {
    //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
    String url = 'https://staging.abisiniya.com/api/v1/booking/apartment/withbooking';
    //var token = '296|JeKFHy6w6YIIvbeDmRIZ3zLFXOF3WRWptD3FddoD';
    print('sts token..');
    print(RetrivedBearertoekn);
    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        // 'Authorization':
        // 'Bearer <--your-token-here-->',
        "Authorization": "Bearer $RetrivedBearertoekn",

      },
    );
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var picstrr = data1['data'];
      for (var record in picstrr) {
        var pictures = record['bookings'];
        for (var pics in pictures) {
          var pivotdata = pics['pivot'];
          //print('pivot array.....');
          //print(pivotdata);
          int bookable_id = 0;
          bookable_id = pivotdata['bookable_id'];
          print('Retrive bookabi id');
          print(bookable_id);
          if (bookable_id == Bookable_iD) {
            pivotsts = pivotdata['status'];
            startDatestr = pivotdata['start_date'];
            endDatestr = pivotdata['end_date'];
            getbookingData.add(pivotsts);
            startDateList.add(startDatestr);
            endDateList.add(endDatestr);
          }
        }
      }
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Abisiniya',
        ),
        // backgroundColor: const Color(0xff764abc),
        backgroundColor: Colors.green,

      ),
      body: FutureBuilder<dynamic>(

        //future: BookingDashboardUsers,
          future: getData(),

        //future: BookinguserList,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                print('imagename......');
                return Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return InkWell(

                      child:Column(
                        children: <Widget>[
                          Container(color: Colors.black12, height: 110,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 140,
                                      height: 35,
                                      color: Colors.white30,
                                      child: Text('Owner:',style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 35,
                                      color: Colors.white30,
                                      child: Text('----',style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 140,
                                      height: 35,
                                      color: Colors.white30,
                                      child: Text('Address:',style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 35,
                                      color: Colors.white30,
                                      child: Text(RetrivedAdress,style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 140,
                                      height: 35,
                                      color: Colors.white30,
                                      child: Text('City:',style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 35,
                                      color: Colors.white30,
                                      child: Text(Retrivedcityvalue,style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),

                                  ],
                                ),
                              ],
                            ),

                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white70,
                              child: LayoutBuilder(
                                builder: (context, constraint) {
                                  return SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: Column(
                                      children: <Widget>[
                                        //Text('Your Apartments'),
                                        //Text('Your Apartments:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),

                                        ListView.separated(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: getbookingData.length,
                                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                height: 140,
                                                width: 100,
                                                alignment: Alignment.center,
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                  Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                height: 35,
                                                                width: 140,
                                                                color: Colors.white10,
                                                                child: Text('check-in:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              ),
                                                              Container(
                                                                height: 35,
                                                                width: 200,
                                                                color: Colors.white,
                                                                 child: Text(startDateList[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              )
                                                            ],
                                                          ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 140,
                                                          color: Colors.white10,
                                                          child: Text('check-out:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 200,
                                                          color: Colors.white,
                                                          child: Text(endDateList[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 140,
                                                          color: Colors.white10,
                                                          child: Text('Status:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 200,
                                                          color: Colors.white,
                                                          child: Text(getbookingData[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 140,
                                                          color: Colors.white,
                                                          child: Text('Action:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 100,
                                                          color: Colors.white,
                                                          child: Text('Approve',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue),),
                                                        ),

                                                        Container(
                                                          height: 35,
                                                          width: 100,
                                                          color: Colors.white,
                                                          child: Text('Decline',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.redAccent),),
                                                        )
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              );
                                              //return  Text('Some text');
                                            }),

                                        Column(
                                          children:<Widget>[
                                           // Text('second test'),
                                            ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:0,
                                                itemBuilder: (context,index){
                                                  return  Text('Apartment');
                                                }),

                                          ],
                                        )
                                      ],

                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: ()async {
                        print('View more Tapped button.....');
                      }
                  );



                  //return Column(
                  // return Column(
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Container(
                  //         color: Colors.white,
                  //         child: LayoutBuilder(
                  //           builder: (context, constraint) {
                  //             return SingleChildScrollView(
                  //               child: Container(
                  //                 constraints:
                  //                 BoxConstraints(minHeight: constraint.maxHeight),
                  //                 child: IntrinsicHeight(
                  //                   child: Column(
                  //                     children: [
                  //                       // SizedBox(
                  //                       //   height: 10,
                  //                       // ),
                  //                       Column(
                  //                           children: [
                  //                             Column(
                  //                                 children: [
                  //                                   Padding(
                  //                                     padding: const EdgeInsets.all(8.0),
                  //                                     child: Container(
                  //                                       height: 250,
                  //
                  //                                       child:ListView.separated(
                  //                                         itemCount: (snapshot.data as List<DashboardApart>).length,
                  //                                         separatorBuilder: (BuildContext context, int index) => const Divider(),
                  //                                         itemBuilder: (BuildContext context, int index) {
                  //                                           var abisiniyapic = (snapshot.data as List<DashboardApart>)[index];
                  //                                           //var listData = (snapshot.data as List<DashboardApart>)[index];
                  //
                  //
                  //                                           return Container(
                  //                                             height: 220,
                  //                                             width: 300,
                  //                                             color: Colors.yellow,
                  //                                             child: InkWell(
                  //                                               child: Column(
                  //                                                 children: [
                  //                                                   Container(
                  //                                                     height: 200,
                  //                                                     child: Text(abisiniyapic.address),
                  //                                                     // decoration: BoxDecoration(
                  //                                                     //     image: DecorationImage(image: NetworkImage(abisiniyapic.address),
                  //                                                     //         fit: BoxFit.cover)
                  //                                                     // ),
                  //                                                   ),
                  //                                                 ],
                  //                                               ),
                  //                                               onTap: ()
                  //                                               {
                  //                                                 print('calling.......');
                  //                                                 print([index]);
                  //                                               },
                  //                                             ),
                  //                                           );
                  //                                         },
                  //                                       ),
                  //
                  //                                     ),
                  //                                   ),
                  //                                   Container(
                  //                                     height: 40,
                  //                                     width: 340,
                  //                                     alignment: Alignment.topLeft,
                  //                                     color: Colors.white,
                  //                                     child: Text('Information',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Colors.black)),),
                  //                                   )
                  //                                   // Container(
                  //                                   //   height: 50,
                  //                                   //   width: 280,
                  //                                   //   color: Colors.orange,
                  //                                   //   // child:Text(snapshot.data['data'][10]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                  //                                   // ),
                  //                                 ]
                  //                             ),
                  //                           ]
                  //                       ),
                  //                       // middle widget goes here
                  //
                  //
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // );
                }
            }
          }
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 50,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
