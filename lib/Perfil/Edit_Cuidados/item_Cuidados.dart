import 'package:flutter/material.dart';

import 'package:proyecto_app_moviles/Perfil/Edit_Cuidados/item_Cuidados_edit.dart';

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
                        color: Colors.lightGreen,
                        child: Text("Editar"),
                        onPressed:(){
                          //Obtener la infomacion de la imagen que editare. Necesito el Doc
                          String dataToEdit = widget.allCuidadosData["docId"];
                          bool switchValue = widget.allCuidadosData["public"];
                          //print(dataToEdit);
                          //BlocProvider.of<MisfotosBloc>(context).add(OnClickEditarButtonEvent(dataToEdit: dataToEdit));
                          //Usar Navigation.push
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => MisCuidadosEdit(
                              docIdString: dataToEdit, 
                              switchCurrentValue:switchValue,
                              currentImage: widget.allCuidadosData["picture"],
                              currentName: widget.allCuidadosData["title"],
                              currentDescription: widget.allCuidadosData["description"],
                            ))
                          );
                        }
                      ),
                    ],
                  ),
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