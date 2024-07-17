import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderHistory extends StatefulWidget {
  final int id;
  const OrderHistory({super.key,required this.id});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {

  DateTimeRange? _selectedDateRange;
  int? totalCount;
  int? pendingCount;
  int? completedCount;
  int? otherCount;
  int? cashCount;
  double? sumCount;

  @override
  void initState() {
    _postData();
    super.initState();
  }

  Future<void> _postData() async {
    try {
      final response = await http.post(
        Uri.parse("http://tarkiz-chn-dev.southindia.cloudapp.azure.com:9000/api/DriverDxbOrder/GetOrderHistoryCount"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, dynamic>{
          "driverId":widget.id,
          "fromDate":"2024-07-01",
          "toDate":"2024-07-16"
        }),
      );
      if (response.statusCode == 200) {
        final responseData = await jsonDecode(response.body);
        if(responseData['statusCode']==200){
          setState(() {
            totalCount=responseData['data']['totalOrderCount'];
            pendingCount=responseData['data']['pendingOrderCount'];
            completedCount=responseData['data']['completedOrderCount'];
            otherCount=responseData['data']['otherOrderCount'];
            cashCount=responseData['data']['cashCount'];
            sumCount=responseData['data']['sumOfCash'];
          });
        }
        else{
          const Center(child: CircularProgressIndicator(),);
          const snackdemo = SnackBar(
            content: Text('Data Incorrect'),
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        }
      } else {
        const snackdemo = SnackBar(
          content: Text('Data Error '),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      }
    } catch (e) {
      setState(() {
        final snackdemo = SnackBar(
          content: Text('Error $e'),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 89, 244, 2),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined,color: Colors.white,),),
        title: const Text('Order History',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),),
        toolbarHeight: MediaQuery.of(context).size.height/8.2,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(21),topLeft: Radius.circular(21))
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 13,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Orders',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  GestureDetector(
                    onTap: ()async{
                      // This function will be triggered when the floating button is pressed
                      final DateTimeRange? result = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2024, 1, 1),
                        lastDate: DateTime(2030, 12, 31),
                        currentDate: DateTime.now(),
                        saveText: 'Done',
                      );

                      if (result != null) {
                        // Rebuild the UI
                        print(result.start.toString());
                        setState(() {
                          _selectedDateRange = result;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(9)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined),
                            _selectedDateRange==null?
                            const Text('01/07/24 - 16/07/24'):
                            Text(' ${_selectedDateRange!.start.day}/${_selectedDateRange!.start.month}/${_selectedDateRange!.start.year.toString().substring(2)} - ${_selectedDateRange!.end.day}/${_selectedDateRange!.end.month}/${_selectedDateRange!.end.year.toString().substring(2)}')
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 12,),
              Card(
                elevation: 20,
                borderOnForeground: true,
                color: Colors.white,
                shadowColor: Colors.black,
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text('$totalCount',style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26
                                  ),),
                                  const Text('Total Orders   ',style: TextStyle(
                                      color:  Color.fromRGBO(50, 89, 244, 2),
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ),
                              const VerticalDivider(),
                              Column(
                                children: [
                                  Text('$pendingCount',style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26
                                  ),),
                                  const Text('Pending Delivery',style: TextStyle(
                                      color:  Colors.deepOrange,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text('$completedCount',style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26
                                  ),),
                                  const Text('Completed',style: TextStyle(
                                      color:  Colors.green,
                                      fontWeight: FontWeight.w500
                                  ),),
                                  const Text('Delivery',style: TextStyle(
                                      color:  Colors.green,
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ),
                              const VerticalDivider(),
                              Column(
                                children: [
                                  Text('$otherCount',style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26
                                  ),),
                                  Text('Other Orders',style: TextStyle(
                                      color:  Colors.purple[400],
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                ),
              ),
              SizedBox(height: 19,),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Text('Cash Orders',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                                  ),),
                  ),
                ],
              ),
              const SizedBox(height: 11,),
              Container(
                height: MediaQuery.of(context).size.height/8,
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(9)
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 20,),
                          const Text('Total Cash Orders'),
                          Text('$cashCount',style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26
                          ),)
                        ],
                      ),
                      const VerticalDivider(
                        indent: 15,
                        endIndent: 45,
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 20,),
                          const Text('Total Cash In Hand'),
                          Text('AED$sumCount',style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
