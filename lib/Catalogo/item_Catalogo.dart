import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Pago/bloc/pago_bloc.dart';

class ItemCatalogo extends StatefulWidget {
  final Map<String, dynamic> allCatalogoData;
  ItemCatalogo({Key? key, required this.allCatalogoData}) : super(key: key);

  @override
  State<ItemCatalogo> createState() => _ItemCatalogoState();
}

class _ItemCatalogoState extends State<ItemCatalogo> {
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
                      child: Image.network(widget.allCatalogoData["picture"].toString(), fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    children: [
                      FittedBox(
                        child: Container(
                          child: Text(widget.allCatalogoData["title"].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),),
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
                                  leading: Image.network(widget.allCatalogoData["picture"].toString(), fit: BoxFit.cover),
                                  title: Text(widget.allCatalogoData["title"].toString(),),
                                  trailing: Text("\$${widget.allCatalogoData['price'].toString()}"),
                                ),
                                content: Text(widget.allCatalogoData["description"].toString()),
                                actions: [
                                  TextButton(onPressed: (){
                                    BlocProvider.of<PagoBloc>(context).add(AddPagoEvent(itemId: widget.allCatalogoData["docId"]));Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Planta agregada al carrito", style: TextStyle(color: Colors.black),), backgroundColor: Colors.green,));
                                  }, 
                                  child: Text("Comprar", style: TextStyle(color: Colors.yellow[700]),)),
                                  TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Aceptar", style: TextStyle(color: Colors.yellow[700]),)),
                                ],
                              );
                            }
                          );
                        }
                      ),
                    ],
                  ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       color: Color.fromARGB(158, 31, 31, 31),
                  //       child: ListTile(
                  //         textColor: Colors.white,
                  //         title: Text(widget.allCatalogoData["title"].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                  //         subtitle: Text(widget.allCatalogoData["description"].toString()),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  
                ]
              )  
              ,
            ),
            // AspectRatio(
            //   aspectRatio: 16/9,
            //   child: Image.network("https://t1.uc.ltmcdn.com/es/posts/6/9/5/como_cuidar_las_plantas_suculentas_guia_de_cuidados_47596_orig.jpg", fit: BoxFit.cover),
            // ),
            
          ],
        ),
      ),
    );
  }
}