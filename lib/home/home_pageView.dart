
// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:notesapp_sqflite/sqflite/sqflite.dart';
import 'package:notesapp_sqflite/widgets/Custom_note.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}
SqfLite instanceOfSQF=  SqfLite();
GlobalKey<FormState> keey = GlobalKey();
String? title;
String? note;
Future<List<Map>> getdata()async {
List<Map> data = await instanceOfSQF.selectData(selectSQLQuery: "SELECT * FROM Notes ");
return data;

}
class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    
    return  SafeArea(
      child: Form(
        key: keey,
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.deepPurple,
          title: const Text('Notes',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic),),
          centerTitle: true,),
         floatingActionButton: FloatingActionButton(
          onPressed: ()async{
           showModalBottomSheet(context: context, builder: (context) {
             return Center(
               child: Padding(
                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,
                 top: 20),
                 child: CustomScrollView(
                   slivers: [SliverFillRemaining(
                    hasScrollBody: false,
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: [
                       TextFormField(
                        onChanged: (value) {
                          title=value;
                        },
                        validator: (value) {
                          if(value==null){
                            return "can't be null";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          ),
                          hintText: 'Title'
                        ),
                        ),
                        const SizedBox(height: 20,)
                      ,
                      TextFormField(
                        onChanged: (value) {
                          note=value;
                        },
                        validator: (value) {
                          if(value==null){
                            return "can't be null";
                          }
                          return null;},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                          ),
                          hintText: 'Your note'
                        ),
                      ),
                      ElevatedButton(
                        onPressed: ()async{
                          if(keey.currentState!.validate()){
                          await instanceOfSQF.insertData(
                            insertSQLQuery: "INSERT INTO 'Notes' ('title','NotesData') VALUES ('$title','$note') ");
                            setState(() {
                              
                            });
                            }
                            else{
                              
                            }
                        }, 
                        child:const Text('Add note'))],
                     ),
                   ),
                 ]),
               ),
             );
           },);
          },child: 
          const Icon(Icons.add),),

          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FutureBuilder(
              future:getdata(),
              builder:(context,AsyncSnapshot<List<Map>> snapshot) {
                if(snapshot.hasData){
                  if (snapshot.data!.isEmpty){
                    return const Center(child: Text('No Notes added..yet!'));
                  }
                 return CustomScrollView(
                slivers: [
                  SliverList.separated(
                    separatorBuilder: (context, index) =>const SizedBox(height: 20,),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                   CustomNote(
                    onTap: () async{
                     int res= await instanceOfSQF.deletetData(deleteSQLQuery: "DELETE FROM 'Notes' WHERE NotesData='${snapshot.data![index]['NotesData']}'");
                      print(res);
                      setState(() {
                        
                      });
                    },
                    title: '${snapshot.data![index]['title']}', subtitle: '${snapshot.data![index]['NotesData']}'),)
                ],
              );
              }
              else{
                return const Center(child: CircularProgressIndicator(),);
              }
              }
            ),
          )
        ),
      ),
    );
  }
}