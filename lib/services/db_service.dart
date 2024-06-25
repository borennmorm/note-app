import 'package:note_app/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  // Singleton Pattern: Ensures that only one instance of DBService exists throughout the app.
  // This is done using a private constructor _internal and a factory constructor that returns the same instance (_instance).
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  DBService._internal();

  // - Database Variable: A private variable _database that holds the instance of the SQLite database.
  // - Getter for Database: Checks if the database is already initialized. If not, it calls _initDB to initialize it.
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // - Path to Database: Combines the directory path for databases with the database name (notes.db).
  // - Open Database: Opens the database at the specified path, with version 1, and calls _onCreate if the database does not exist.
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create Table: Executes a SQL command to create the notes table with id, title, and content columns.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT
      )
    ''');
  }

  // Insert Operation: Converts a Note object to a map and inserts it into the notes table. Returns the id of the inserted row.
  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  // Update Operation: Updates the existing note in the notes table based on the id.
  Future<int> updateNote(Note note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Delete Operation: Deletes the note from the notes table based on the id.
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      'notes',
      where: 'id =?',
      whereArgs: [id],
    );
  }

  // Query Operation: Retrieves all notes from the notes table, converts them to Note objects, and returns a list of these objects.
  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }
}



// 1. **Singleton Pattern**:
//    - Ensures a single instance of `DBService` using a private constructor (`_internal`) and a factory constructor (`DBService()`).

// 2. **Database Instance**:
//    - A private variable `_database` holds the SQLite database instance.
//    - The `database` getter checks if `_database` is initialized; if not, it calls `_initDB()` to initialize it.

// 3. **Database Initialization**:
//    - `_initDB()` constructs the database file path and opens the database, invoking `_onCreate()` if it's the first time the database is created.

// 4. **Database Creation**:
//    - `_onCreate()` executes SQL to create the `notes` table with columns: `id`, `title`, and `content`.

// 5. **Insert Operation**:
//    - `insertNote(Note note)` converts a `Note` object to a map and inserts it into the `notes` table, returning the ID of the inserted row.

// 6. **Update Operation**:
//    - `updateNote(Note note)` updates an existing note in the `notes` table based on its `id`.

// 7. **Delete Operation**:
//    - `deleteNote(int id)` deletes a note from the `notes` table based on its `id`.

// 8. **Query Operation**:
//    - `getNotes()` retrieves all notes from the `notes` table, converts each row to a `Note` object, and returns a list of these objects.

// ### Summary of Operations:

// - **Initialization**: Ensures a single instance of `DBService` and initializes the database.
// - **Database Creation**: Creates a `notes` table with specified columns.
// - **CRUD Operations**:
//   - **Create**: Insert a new note into the database.
//   - **Read**: Retrieve all notes from the database.
//   - **Update**: Modify an existing note based on its ID.
//   - **Delete**: Remove a note from the database based on its ID.