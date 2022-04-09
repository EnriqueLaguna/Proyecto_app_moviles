import 'package:flutter/material.dart';

class ItemCuidados extends StatefulWidget {
  final Map<String, dynamic> allCuidadosData;
  ItemCuidados({Key? key, required this.allCuidadosData}) : super(key: key);

  @override
  State<ItemCuidados> createState() => _ItemCuidadosState();
}

class _ItemCuidadosState extends State<ItemCuidados> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Card( 
        child: Stack(
          children: [
            Container(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    child: AspectRatio(
                      aspectRatio: 17/20,
                      child: Image.network(widget.allCuidadosData["picture"].toString(), fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    children: [
                      FittedBox(
                        child: Container(
                          child: Text(widget.allCuidadosData["title"].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),),
                          color: Colors.black54,
                        ),
                        fit: BoxFit.cover,
                      ),
                      Spacer(),
                      MaterialButton(
                        color: Colors.yellow,
                        child: Text("Ver"),
                        onPressed:(){
                          showDialog(
                            context: context, 
                            builder: (BuildContext){
                              return AlertDialog(
                                title: ListTile(
                                  leading: Image.network(widget.allCuidadosData["picture"].toString(), fit: BoxFit.cover),
                                  title: Text(widget.allCuidadosData["title"].toString(),),
                                  trailing: Text("${widget.allCuidadosData['likes'].toString()} likes"),
                                ),
                                content: Text(widget.allCuidadosData["description"].toString()),
                                actions: [
                                  TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Salir", style: TextStyle(color: Colors.yellow[700]),)),
                                ],
                              );
                            }
                          );
                        }
                      ),
                    ],
                  ),  
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}