import 'package:flutter/material.dart';
import 'package:kisiler_listesi_flutter/OOP/Kisiler.dart';
import 'package:kisiler_listesi_flutter/Sayfalar/main.dart';
import 'package:kisiler_listesi_flutter/VeriTabaniIslemleri/KisilerDao.dart';
// ignore: must_be_immutable
class Detay extends StatefulWidget {
  Kisiler kisi;

  Detay({super.key, required this.kisi});

  @override
  State<Detay> createState() => _DetayState();
}

class _DetayState extends State<Detay> {

  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();


  Future<void> guncelle(int param0, String param1, String param2) async{
    await KisilerDao().kisiGuncelle(param0, param1, param2);

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
  }


  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAdi.text = kisi.kisi_ad;
    tfKisiTel.text = kisi.kisi_tel;
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Kişi Detayı"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[


              TextField(
                controller: tfKisiAdi,
                decoration: const InputDecoration(hintText: "Kişi Adı",),
              ),

              TextField(
                controller: tfKisiTel,
                decoration: const InputDecoration(hintText: "Kişi Cep Telefonu",),
              ),


            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          guncelle(widget.kisi.kisi_id, tfKisiAdi.text, tfKisiTel.text);
        },
        tooltip: 'Kişi Güncelle',
        icon: const Icon(Icons.update_outlined),
        label: const Text("Güncelle"),
      ),
    );
  }
}
