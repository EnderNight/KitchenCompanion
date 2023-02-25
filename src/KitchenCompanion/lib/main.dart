import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/food.dart';

void main() {

    DbManager.dbManager.create(const Food(name: 'pates', quantity: 10));
    DbManager.dbManager.create(const Food(name: 'riz', quantity: 20));
    DbManager.dbManager.create(const Food(name: 'patates', quantity: 30));


    runApp(const KitchenCompanionApp());
}

class KitchenCompanionApp extends StatelessWidget {
    const KitchenCompanionApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: const Text('Kitchen Companion'),
                ),
                body: Center(
                    child: ListView(
                        children: const [
                            StockList(text: '1')
                        ]),
                ),
            ),
        );
    }
}

class StockList extends StatelessWidget {
    const StockList({required this.text, super.key});

    final String text;

    @override
    Widget build(BuildContext context) {
        return ListTile(
            title: Text(text),
        );
      }
}



class DbManager {

    static final DbManager dbManager = DbManager._init();

    static Database? _database;

    DbManager._init();

    Future<Database> _initDB(String path) async {
        final dbPath = join(await getDatabasesPath(), path);

        return await openDatabase(dbPath, version: 1, onCreate: _createDB);
    }

    Future _createDB(Database db, int version) async {
        
        const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
        const textType = 'TEXT NOT NULL';
        // const intType = 'INTEGER NOT NULL';
        const doubleType = 'REAL NOT NULL';

        await db.execute('''
            CREATE TABLE $tableFood (
            ${FoodFields.id} $idType,
            ${FoodFields.name} $textType,
            ${FoodFields.quantity} $doubleType,
            )
            ''');
    }

    Future<Database> get database async {
        if (_database != null) return _database!;

        _database = await _initDB('kitchenDB.db');
        return _database!;
    }

    Future close() async {
        final db = await dbManager.database;
        db.close();
    }


    // CRUD Operations //
    Future<Food> create(Food food) async {
        final db = await dbManager.database;

        final id = await db.insert(tableFood, food.toMap());

        return food.copy(id: id);
    }

    Future<Food?> read(int id) async {
        final db = await dbManager.database;

        final maps = await db.query(
            tableFood,
            columns: FoodFields.columns, 
            where: '${FoodFields.id} = ?',
            whereArgs: [id],
        );

        if (maps.isNotEmpty) {
            return Food.fromMap(maps.first);
        }

        return null;
    }

    Future<List<Food>> readAll() async {
        final db = await dbManager.database;

        final res = await db.query(tableFood);

        return res.map((e) => Food.fromMap(e)).toList();
    }

    Future<int> update(Food food) async {
        final db = await dbManager.database;

        return db.update(
            tableFood, 
            food.toMap(),
            where: '${FoodFields.id} = ?',
            whereArgs: [food.id],
        );

    }

    Future<int> delete(int id) async {
        final db = await dbManager.database;
        
        return await db.delete(
            tableFood,
            where: '${FoodFields.id} = ?',
            whereArgs: [id],
        );
    }

}
