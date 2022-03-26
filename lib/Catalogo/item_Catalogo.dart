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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16/9,
              child: Image.network("https://t1.uc.ltmcdn.com/es/posts/6/9/5/como_cuidar_las_plantas_suculentas_guia_de_cuidados_47596_orig.jpg", fit: BoxFit.cover),
            ),
            Wrap(
              children: [
                ListTile(
                  title: Text("Suculenta"),
                  subtitle: Text("Planta que parece de plastico"),
                ),
                MaterialButton(
                  color: Colors.lightGreen,
                  child: Text("Ver"),
                  onPressed:(){}
                ),
              ]
            )  
          ],
        ),
      ),
    );
  }
}