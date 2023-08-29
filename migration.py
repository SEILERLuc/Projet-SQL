import sqlite3
import os
import shutil
import time
from os import path

def create_backup(filename) -> None:
    # Function that create the backup of the old database 'tpb2.db'
    # in a new folder
    backup_folder = "old-database-backup"
    try:
        print("Backup of the actual database...")
        time.sleep(2)
        os.mkdir(backup_folder)
        shutil.copy(filename, backup_folder)
        print("Backup complete")
        time.sleep(2)
        print("PATH : THIS-FOLDER/old-database-backup/tpb2.db")
    except (OSError, shutil.Error) as backup_error:
        print(backup_error)

def create_database(name):
    # Function that create the new database 'teamLikwid.db' if not exists
    print("\nCreation of the new database...")
    time.sleep(2)
    conn_new = None
    try:
        conn_new = sqlite3.connect(name)
        print("New database created named -> " + name)
        time.sleep(2)
    except sqlite3.Error as error:
        print(error)
    finally:
        if conn_new:
            conn_new.close()

def create_tables(database):
    # Function that create new tables in the new database, executing 
    # a sqlite file -> 'create-new-database.sql'
    try:
        sqliteConnection = sqlite3.connect(database)
        cursor = sqliteConnection.cursor()
        print("\nCreation of new tables...")
        time.sleep(2)

        with open(r"create-new-database.sql", 'r') as sqlite_file:
            sql_script = sqlite_file.read()

        cursor.executescript(sql_script)
        print("New tables created")
        time.sleep(2)
        cursor.close()
    except sqlite3.Error as error:
        print("Error while connecting to sqlite", error)
    finally:
        if sqliteConnection:
            sqliteConnection.close()
            print("The SQLite connection is closed")

def migrate_data(database):
    # Function that migrate data from old to new database, executing
    # a slite script --> 'migration.sql'
    try:
        sqliteConnection = sqlite3.connect(database)
        cursor = sqliteConnection.cursor()
        print("\nMigration of data...")
        time.sleep(2)

        with open(r"migration.sql", 'r') as sqlite_file:
            sql_script = sqlite_file.read()

        cursor.executescript(sql_script)
        print("Migration script executed successfully")
        time.sleep(2)
        cursor.close()
    except sqlite3.Error as error:
        print("Error while connecting to sqlite", error)
    finally:
        if sqliteConnection:
            sqliteConnection.close()
            print("The SQLite connection is closed")

def migration_manager():
    # Function that manage all the porcess : 
    # Check if database exists, or the backup
    # and make the migration
    new_database_name = "teamLikwid.db"
    if not path.exists("old-database-backup/tpb2.db"):
        create_backup('tpb2.db')
    else :
        print("Backup already exist")
    if path.isfile("teamLikwid.db"):
        print("Database already exist")
    else:
        create_database(new_database_name)
        create_tables(new_database_name)
        migrate_data(new_database_name)
        requests(new_database_name)

def requests(database):
    # Function that execute all the script placed in the folder 
    # Files are requests for the test, after the migration was made
    print("\nTest for the 4 requests")
    time.sleep(2)
    sqliteConnection = sqlite3.connect(database)
    cursor = sqliteConnection.cursor()
    requests_files = os.listdir("sql-requests")

    for filename in requests_files:
        print(filename)
        filename = "sql-requests/"+filename
        with open(filename, 'r') as sqlite_file:
            sql_script = sqlite_file.read()
            cursor.execute(sql_script)
            rows = cursor.fetchall()
        for row in rows:
            print(row)
        time.sleep(1)
        print("\n")

    cursor.close()   
    sqliteConnection.close()     

def main():
    # The main function, that run the migration process
    print("=====DATABASE MIGRATION SQLITE SCRIPT=====")
    time.sleep(2)
    migration_manager()
    print("=============END OF THE SCRIPT============")

if __name__== "__main__":
   main()
