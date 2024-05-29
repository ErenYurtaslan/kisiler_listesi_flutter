import 'package:kisiler_listesi_flutter/OOP/Kisiler.dart';
import 'VeritabaniYardimcisi.dart';

class KisilerDao{

  Future<List<Kisiler>> tumKisiler() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler");

    return List.generate(maps.length, (index){
        var row = maps[index];
        return Kisiler(row["kisi_id"] , row["kisi_ad"], row["kisi_tel"]);
      }
    );
  }





  Future<List<Kisiler>> kisiAra(String aramaKelimesi) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery(
        "SELECT * FROM kisiler"
        " WHERE kisi_ad like '%$aramaKelimesi%' ");

    return List.generate(maps.length, (index){
      var row = maps[index];
      return Kisiler(row["kisi_id"] , row["kisi_ad"], row["kisi_tel"]);
    }
    );
  }






  Future<void> kisiEkle(String kisi_adi, String kisi_telefon) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = <String, dynamic>{}; //Map<String, dynamic>(); de olur.

    bilgiler["kisi_ad"] = kisi_adi;
    bilgiler["kisi_tel"] = kisi_telefon;

    await db.insert("kisiler", bilgiler);
  }




  Future<void> kisiGuncelle(int kisi_id, String kisi_adi, String kisi_telefon) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = <String, dynamic>{}; //Map<String, dynamic>(); de olur.

    bilgiler["kisi_ad"] = kisi_adi;
    bilgiler["kisi_tel"] = kisi_telefon;

    await db.update("kisiler", bilgiler, where: "kisi_id=?",whereArgs: [kisi_id]);
  }






  Future<void> kisiSil(int kisi_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("kisiler",where: "kisi_id=?",whereArgs: [kisi_id]);
  }




}