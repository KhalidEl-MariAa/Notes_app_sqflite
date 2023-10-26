import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLite{




  static Database? _db;

 Future<Database?> get db async {
      if (_db == null){
        _db  = await initalizeDB() ;
        return _db ;  
      }else {
        return _db ; 
      }
 }


    Future<Database?> initalizeDB()async {

    String defaultPath = await getDatabasesPath();
    String dbPath= join(defaultPath,'App.db');
    
        _db= await openDatabase(
        dbPath,
        version: 2,// if we inrement it , the on upgrade will execute
        onUpgrade: (db, oldVersion, newVersion) async {
          // (most common usage) : used To add a new Table to the db after increment the version 
          await deleteDatabase(dbPath);
        },
        onCreate: (db, version) async{
        await db.execute(
          '''
             CREATE TABLE Notes (
             'ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
             'title' TEXT NOT NULL,
             'NotesData' TEXT NOT NULL
        )
        '''
        );
        print('oncreate');
        },);
      return db;
   

 
}

  Future<List<Map>> selectData({required String selectSQLQuery})async {
    Database? dB = await db;
   List<Map> res = await dB!.rawQuery(selectSQLQuery); //"SELECT * FROM Notes "
   return res;
  }

  
  Future<int> insertData({required String insertSQLQuery})async {
    Database? dB = await db;
   int res = await dB!.rawInsert(insertSQLQuery); //"INSERT INTO 'Notes' ('NotesData') VALUES ('note 1') "
   return res;
  }

  Future<int> updateData({required String updateSQLQuery})async {
    Database? dB = await db;
   int res = await dB!.rawUpdate(updateSQLQuery); //"UPDATE 'Notes' SET 'NotesData' = 'note 2' WHERE ID=2"
   return res;
  }

  
  Future<int> deletetData({required String deleteSQLQuery})async {
    Database? dB = await db;
   int res = await dB!.rawDelete(deleteSQLQuery); //"DELETE FROM 'Notes' WHERE ID=3"
   return res;
  }


// Sqlالاوامر ال 
//تتكتب بنفس الطريقه في الكومنتات مع مراعات الكوتيشنز سواء وجودها او غيابها



}