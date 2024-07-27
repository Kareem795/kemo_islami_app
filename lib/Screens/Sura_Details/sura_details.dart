import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:islami_app_kemo/Model/sura_details_args.dart';
import 'package:islami_app_kemo/Utils/app_colors.dart';
import 'package:islami_app_kemo/Utils/app_style.dart';
import 'package:islami_app_kemo/Wedgits/app_scaffold.dart';

class Sura_Details extends StatefulWidget 
{
  Sura_Details({super.key});
  static const String route_name = "sura_details";

  @override
  State<Sura_Details> createState() => _Sura_DetailsState();
}

class _Sura_DetailsState extends State<Sura_Details> 
{
  late Sura_Details_Args args;

  String file_contants = "";

  @override
  Widget build(BuildContext context) 
  {
    args = ModalRoute.of(context)!.settings.arguments as Sura_Details_Args;

    if(file_contants.isEmpty)
    {
      read_file();
    }

    return App_Scaffold
    (
      appBar_title: 'Surah ${args.sura_name}',
      body: file_contants.isEmpty ? build_loding() : build_sura_contant(),
      
      // CircularProgressIndicator() => اذا تاخرت تحميل ايات الصورة تظهر علامة التحميل الدائرية

    );


  }

  Center build_loding()
  {
    return const Center
      (
        child: CircularProgressIndicator
        (
          color: App_Colors.primary,
        )
      );
  }

  Widget build_sura_contant() => Center(
    child: Container
    (
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.all(20),

      decoration: BoxDecoration
      (
        color: App_Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      
      child: SingleChildScrollView
      (
        child: Text
        (
          file_contants , 
          textAlign: TextAlign.center,
          textDirection:TextDirection.rtl,
          style: App_Style.title.copyWith(fontSize: 16),
        ),
      )
    ),
  );

  //-------------------Important-----------------//

  // Note: Study it is important

  Future read_file() async 
  {
    String file_contant = await rootBundle.loadString("assets/files/quran/${args.file_name}");
    
    List<String> file_lines = file_contant.split("\n");
    file_lines = file_lines.where((line) => line.trim().isNotEmpty).toList();
    for(int i = 0 ; i < file_lines.length ; i++)
    {
      file_lines[i] += " (${i + 1}) ";
    }
    file_contants = file_lines.join();
    setState(() {}); // To update UI with the new file content.
  }

  //-------------------Important-----------------//



}