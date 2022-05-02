import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Pago/bloc/pago_bloc.dart';

class Pago extends StatefulWidget {
  Pago({Key? key}) : super(key: key);

  @override
  State<Pago> createState() => _PagoState();
}

class _PagoState extends State<Pago> {
  double total = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito", style: TextStyle(color: Colors.white),),
      ),
      body: BlocConsumer<PagoBloc, PagoState>(
        listener: (context, state) {
          if(state is PagoEliminar){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Elemento eliminado"),
                backgroundColor: Colors.red,
              )
            );
          }
        },
        builder: (context, state) {
          if(state is PagoError || state is PagoInitial)
            return Center(child: CircularProgressIndicator(),);
          List<Map<String, dynamic>> data = (state as PagoSuccess).data;
          return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Row(
                          children: [
                            Image.network("https://www.ikea.com/mx/en/images/products/fejka-artificial-potted-plant-in-outdoor-monstera__0614197_pe686822_s5.jpg", width: 75, height: 75,),
                            Text("Tu pedido", style: TextStyle(fontSize: 18),),
                          ],
                        ),
                        
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 2),),
                        ),
                      ),
                      
                      Container(
                        height: MediaQuery.of(context).size.height*0.4,
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> item = data[index];
                            return Container(
                              margin: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text("${item["title"].toString()}", style: TextStyle(fontSize: 17),),
                                  Text("\$${item["price"].toString()}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                  Container(
                                    width:50,
                                    child: TextFormField(
                                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                                      initialValue: "1",
                                      onChanged: (inputCantidad){
                                        item["cantidad"] = inputCantidad;
                                        calcTotal(data);
                                        setState(() {
                                          
                                        });
                                      },
                                    ),                                    
                                  ),
                                  IconButton(onPressed: (){
                                    BlocProvider.of<PagoBloc>(context).add(DeletePagoEvent(itemId: item["docId"]));
                                  }, 
                                  icon: Icon(Icons.remove_circle),
                                  color: Colors.red,
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 2),),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Text("\$${calcTotal(data)}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Método de pago", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                        Icon(Icons.payments),
                                        Text("Efectivo", style: TextStyle(fontSize: 18, color: Colors.grey.shade700),),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(Icons.edit),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 2),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Dirección", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                        Icon(Icons.person_pin_circle_rounded),
                                        Text("López Mateos 1561", style: TextStyle(fontSize: 18, color: Colors.grey.shade700),),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(Icons.edit),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 2),),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 360,
                        child: ElevatedButton(
                          onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Compra realizada!", style: TextStyle(color: Colors.black),), backgroundColor: Colors.amber[200],));
                            BlocProvider.of<PagoBloc>(context).add(ClearPagoEvent());
                            Navigator.pop(context);
                          }, 
                          child: const ListTile(title: Text("Realizar pedido", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)),
                          style: ButtonStyle(
                            
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(150),),
                              )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            );
        },
      ),
    );
  }

  String calcTotal(List<Map<String, dynamic>> data) {
    double r = 0;
    for (var item in data){
      try{
         r+=(item["price"] as num) * int.parse(item["cantidad"]);
      }catch(e){
        r+=(item["price"] as num);
      }
    } 
    return r.toString();
  }
}