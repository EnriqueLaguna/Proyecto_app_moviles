import 'package:flutter/material.dart';

class ItemCatalogo extends StatefulWidget {
  // final Map<String, dynamic> allCatalogoData;
  ItemCatalogo({Key? key, /*required this.allCatalogoData*/}) : super(key: key);

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
                      child: Image.network("https://t1.uc.ltmcdn.com/es/posts/6/9/5/como_cuidar_las_plantas_suculentas_guia_de_cuidados_47596_orig.jpg", fit: BoxFit.cover),
                    ),
                  ),
                  // Image.network("https://t1.uc.ltmcdn.com/es/posts/6/9/5/como_cuidar_las_plantas_suculentas_guia_de_cuidados_47596_orig.jpg", 
                  // fit: BoxFit.cover
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Color.fromARGB(158, 31, 31, 31),
                        child: ListTile(
                          textColor: Colors.white,
                          title: Text("Suculenta",),
                          subtitle: Text("Planta que parece de plastico"),
                        ),
                      ),
                      MaterialButton(
                        color: Colors.yellow,
                        child: Text("Ver"),
                        onPressed:(){}
                      ),
                    ],
                  )
                  
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