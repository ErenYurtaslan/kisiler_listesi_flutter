import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kisiler_listesi_flutter/OOP/Kisiler.dart';
import 'package:kisiler_listesi_flutter/Sayfalar/Detay.dart';
import 'package:kisiler_listesi_flutter/Sayfalar/KisiKayitSayfasi.dart';
import '../VeriTabaniIslemleri/KisilerDao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Anasayfa(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Anasayfa extends StatefulWidget {


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {




  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";





  Future<List<Kisiler>> tumKisileriGoster() async{
    var kisilerListesi = await KisilerDao().tumKisiler();

    return kisilerListesi;
  }



  Future<List<Kisiler>> aramaYap(String aramaKelimesi) async{
    var kisilerListesi = await KisilerDao().kisiAra(aramaKelimesi);

    return kisilerListesi;
  }




  Future<void> sil(int kisi_id) async{
    await KisilerDao().kisiSil(kisi_id);
    setState(() {
      }
    );
  }




  Future<bool> closeApp() async{
     await exit(0);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(





      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,


        leading: IconButton(
            onPressed: (){
          closeApp();
        },
            icon: const Icon(Icons.arrow_back_ios)),


        title: aramaYapiliyorMu ?
        TextField(
          decoration: const InputDecoration(
            hintText: "Aramak için bir şey yazın",
          ),
          onChanged: (aramaSonucu){
            print("Arama sonucu : $aramaSonucu");
            setState(() {
              aramaKelimesi = aramaSonucu;
            });
          },
        )


            :


        const Text("Kişiler Listesi"),


        actions: [
          aramaYapiliyorMu ?


          IconButton(
          onPressed: (){
            setState(() {
              aramaYapiliyorMu = false;
              aramaKelimesi = "";
               });
            },
           icon: const Icon(Icons.cancel_outlined),
            )



          :


          IconButton(
              onPressed: (){
                setState(() {
                  aramaYapiliyorMu = true;
                });
              },
               icon: const Icon(Icons.person_search_outlined),
            ),


        ],
      ),















      body: WillPopScope(
        onWillPop: closeApp,
        child: FutureBuilder<List<Kisiler>>(


          future: aramaYapiliyorMu?

          aramaYap(aramaKelimesi)      :     tumKisileriGoster(),





          builder: (context,snapshot){


            if(snapshot.hasData){
              var kisilerListesi = snapshot.data;
                return ListView.builder(
                    itemCount: kisilerListesi!.length,
                    itemBuilder: (context,index){
                      var kisiMain = kisilerListesi[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Detay(kisi: kisiMain,)));
                        },
                        child: Card(
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(kisiMain.kisi_ad,style: const TextStyle(fontWeight: FontWeight.bold),),
                                Text(kisiMain.kisi_tel),
                                IconButton(
                                    onPressed: (){
                                      sil(kisiMain.kisi_id);
                                    },
                                    icon: const Icon(Icons.delete_forever_outlined) ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
            }else{
              return Container(
                color: Colors.indigoAccent,
              );
            }
          }
        ),
      ),
















      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const KisiKayit()));
        },
        tooltip: 'Kişi Ekle',
        child: const Icon(Icons.add_card),
      ),
















    );
  }
}