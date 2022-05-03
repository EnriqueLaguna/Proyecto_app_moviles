import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Mapa extends StatefulWidget {
  Mapa({Key? key}) : super(key: key);

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(
                    "https://map.viamichelin.com/map/carte?map=viamichelin&z=10&lat=20.67517&lon=-103.34733&width=550&height=382&format=png&version=latest&layer=background&debug_pattern=.*")
                )
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 18),),
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Pedido 1"),
                            content: Container(
                              height: 450,
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Cactus silvetre x2"),
                                  Text("Eucalipto x3"),
                                  SizedBox(height: 100.0),
                                  Image.network("https://appassets.mvtdev.com/map/48/l/5996/27891507/4647843.jpg")
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Text("Cerrar")),
                            ],
                          );
                        });
                      },
                      child: Text("Pedido 1",style: TextStyle(color: Colors.black),),
                      ),
                      Text("En camino", style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Text("Entregar a <dirección>", style: TextStyle(fontSize: 18, color: Colors.grey.shade500),),
                SizedBox(height: 15.0),
                LinearPercentIndicator(
                  width: 300.0,
                  lineHeight: 6.0,
                  percent: 0.75,
                  progressColor: Colors.lightGreen,
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 5.0),
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(
                    "https://map.viamichelin.com/map/carte?map=viamichelin&z=10&lat=20.67517&lon=-103.34733&width=550&height=382&format=png&version=latest&layer=background&debug_pattern=.*")
                )
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 18),),
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Pedido 2"),
                            content: Container(
                              height: 450,
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Cactus silvetre x2"),
                                  Text("Eucalipto x3"),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Text("Cerrar")),
                            ],
                          );
                        });
                      },
                      child: Text("Pedido 2",style: TextStyle(color: Colors.black),),
                      ),
                      Text("Completado", style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Text("Entregar a <dirección>", style: TextStyle(fontSize: 18, color: Colors.grey.shade500),),
                SizedBox(height: 15.0),
                LinearPercentIndicator(
                  width: 300.0,
                  lineHeight: 6.0,
                  percent: 1.0,
                  progressColor: Colors.lightGreen,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}