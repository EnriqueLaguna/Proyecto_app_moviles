import 'package:flutter/material.dart';

class Pago extends StatefulWidget {
  Pago({Key? key}) : super(key: key);

  @override
  State<Pago> createState() => _PagoState();
}

class _PagoState extends State<Pago> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: [
                  Image.network("https://www.ikea.com/mx/en/images/products/fejka-artificial-potted-plant-in-outdoor-monstera__0614197_pe686822_s5.jpg", width: 75, height: 75,),
                  Text("Pedido 1", style: TextStyle(fontSize: 18),),
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
                      Text("Cactus silvestre", style: TextStyle(fontSize: 17),),
                      Text("\$50.00", style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("x2", style: TextStyle(fontSize: 17),),
                      Text("\$100.00", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
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
                      Text("Eucalipto", style: TextStyle(fontSize: 17),),
                      Text("\$22.00", style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("x3", style: TextStyle(fontSize: 17),),
                      Text("\$66.00", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
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
                      Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      Text("\$166.00", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
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
                onPressed: (){}, 
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
    );
  }
}