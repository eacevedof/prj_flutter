//file: product_model.dart
//generador: https://app.quicktype.io/
import 'dart:convert';

//recibe un json en string y devuelve una instancia del modelo
ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

//recibe un modelo y devuelve un json
String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {

    String id;
    String titulo;
    double valor;
    bool disponible;
    String fotoUrl;

    ProductoModel({
        this.id,
        this.titulo = '',
        this.valor  = 0.0,
        this.disponible = true,
        this.fotoUrl,
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => new ProductoModel(
        id         : json["id"],
        titulo     : json["titulo"],
        valor      : json["valor"],
        disponible : json["disponible"],
        fotoUrl    : json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //"id"         : id, lo excluyo para que no se duplique la información
        //es decir, se crearía un nodo: id
        "titulo"     : titulo,
        "valor"      : valor,
        "disponible" : disponible,
        "fotoUrl"    : fotoUrl,
    };

}//class ProductoModel
