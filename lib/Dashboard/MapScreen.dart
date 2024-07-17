import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task/Dashboard/OrderHistory.dart';

class DashboardScreen extends StatefulWidget {
  final String responseImage;
  final String firstName;
  final String lastName;
  final int driverId;
  const DashboardScreen({
    super.key,
    required this.responseImage,
    required this.firstName,
    required this.lastName,
    required this.driverId
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>{
  List<bool> isSelected = [true, false];
  bool value=false;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(11.003237, 76.975816),
    zoom: 11.5,
  );


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(50, 89, 244, 2),
        appBar: AppBar(
          leadingWidth: 80,
          toolbarHeight: MediaQuery.of(context).size.height/8,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistory(id: widget.driverId,)));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.responseImage),
              ),
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.firstName} ${widget.lastName}',style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),),
              const Text('Deira - Dubai',style: TextStyle(
                  color: Colors.white
              ),)
            ],
          ),
          actions: [
            Switch(
              inactiveThumbColor: Colors.white,
              activeTrackColor: const Color.fromRGBO(4, 193, 54, 2),
                inactiveTrackColor: const Color.fromRGBO(236, 13, 13, 2),
                value: value,
                onChanged: (val){
                  setState(() {
                    value=!value;
                  });
                }),
            SizedBox(width: 8,),
            Icon(CupertinoIcons.qrcode_viewfinder,color: Colors.white,),
            SizedBox(width: 8,),
            Icon(CupertinoIcons.search,color: Colors.white,),
            SizedBox(width: 10,)

          ],
        ),
        body: value==false?
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(21),topLeft: Radius.circular(21))
            ),
              child: const GoogleMap(
                myLocationButtonEnabled: true,
                compassEnabled: true,
                zoomGesturesEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
              ),
          ),
        ):
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(21),topLeft: Radius.circular(21))
          ),
          child: Column(
            children: [
              SizedBox(height: 18,),
              ToggleButtons(
                  onPressed: (int newIndex) {
                    setState(() {
                      // looping through the list of booleans values
                      for (int index = 0; index < isSelected.length; index++) {
                        // checking for the index value
                        if (index == newIndex) {
                          // one button is always set to true
                          isSelected[index] = true;
                        } else {
                          // other two will be set to false and not selected
                          isSelected[index] = false;
                        }
                      }
                    });
                  },
                borderWidth: 0,
                borderRadius: BorderRadius.circular(25),
                  disabledColor: Colors.black12,
                  selectedColor: const Color.fromRGBO(50, 89, 244, 2),
                  fillColor: Colors.blue[50],
                  children: [
                Text('     Currents Orders     ',style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Text('     Upcoming Orders     ',style: TextStyle(
                    fontWeight: FontWeight.bold
                ),)
              ],
                  isSelected: isSelected),
              const SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 20,
                  borderOnForeground: true,
                  color: Colors.white,
                  shadowColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Order No. '),
                                Text('984501233',style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                            Text('06/04/2024 12:20:00')
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Customer Name'),
                                SizedBox(height: 5,),
                                Text('Faizan',style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Order Status'),
                                const SizedBox(height: 5,),
                                Container(
                                  decoration: BoxDecoration(
                                    color:const Color.fromRGBO(4, 193, 54, 2),
                                    borderRadius: BorderRadius.circular(9)
                                  ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Vehicle Assigned',style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    ))
                              ],
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 6,),
                                Text('Address'),
                                SizedBox(height: 10,),
                                Text('Lorem Ipsum Dolor Sit Amet, Consectetur',style: TextStyle(
                                  color: Colors.black,
                                    fontWeight: FontWeight.w500
                                ),),
                                Text('Adipiscing Elit, Sed Do Eiusmod',style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500

                                ),)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 20,
                  borderOnForeground: true,
                  color: Colors.white,
                  shadowColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Order No. '),
                                Text('984501233',style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                            Text('06/04/2024 12:20:00')
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Customer Name'),
                                SizedBox(height: 5,),
                                Text('Faizan',style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Order Status'),
                                const SizedBox(height: 5,),
                                Container(
                                    decoration: BoxDecoration(
                                        color:const Color.fromRGBO(236, 13, 13, 2),
                                        borderRadius: BorderRadius.circular(9)
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Not Assigned',style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    ))
                              ],
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 6,),
                                Text('Address'),
                                SizedBox(height: 10,),
                                Text('Lorem Ipsum Dolor Sit Amet, Consectetur',style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                                ),),
                                Text('Adipiscing Elit, Sed Do Eiusmod',style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                                ),)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        )
      ),
    );
  }
}
