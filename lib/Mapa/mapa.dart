import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:proyecto_app_moviles/Mapa/bloc/mapa_bloc.dart';
import 'package:proyecto_app_moviles/Mapa/tracking_page.dart';

class Mapa extends StatefulWidget {
  Mapa({Key? key}) : super(key: key);

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder(
      query: FirebaseFirestore.instance.collection("shippings").where("buyer", isEqualTo: FirebaseAuth.instance.currentUser!.uid), 
      builder: (con, snap, it){
        return ListView.builder(
          itemCount: snap.docs.length,
          itemBuilder: (BuildContext context, int index) {
            var doc = snap.docs[index];
            return GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Pedido ${index+1}"),
                    content: Container(
                      height: 200,
                      width: 300,
                      child: ListView.builder(
                        itemCount: doc["shipElements"].length,
                        itemBuilder: (BuildContext context, int index) {
                          var element = doc["shipElements"][index];
                          return ListTile(
                            title: Text(element["title"].toString()),
                            subtitle: Text("${element["seller"].toString()}"),
                            trailing: Column(
                              children: [
                                Text("\$${element["price"].toString()}", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("x"+((element["cantidad"]==null)?"1":element["cantidad"].toString()))
                              ],mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end,
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          BlocProvider.of<MapaBloc>(context).add(DeletePedidoEvent(itemId: doc.id));
                          Navigator.of(context).pop();
                        },
                        child: Text("Confirmar recepción", style: TextStyle(color: Colors.yellow[700]),)
                      ),
                      TextButton(
                        onPressed: (){Navigator.of(context).pop();},
                        child: Text("Aceptar", style: TextStyle(color: Colors.yellow[700]),)
                      ),
                    ],
                  );
                });
              },
              child: ListTile(
                title: Text("Pedido ${index+1}"),
                trailing: Text("\$${(doc["price"] as double).toStringAsFixed(2)}"),
                subtitle: LinearPercentIndicator(
                  lineHeight: 6.0,
                  percent: Random().nextDouble(),
                  progressColor: Colors.lightGreen,
                ),
                leading: MaterialButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingPage(location: doc["location"]),)),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage("https://map.viamichelin.com/map/carte?map=viamichelin&z=10&lat=20.67517&lon=-103.34733&width=550&height=382&format=png&version=latest&layer=background&debug_pattern=.*"),
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
}
