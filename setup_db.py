import ssl
import urllib.request
import os

url = "https://raw.githubusercontent.com/lerocha/chinook-database/master/ChinookDatabase/DataSources/Chinook_Sqlite.sqlite"
db_filename = "chinook.db"

if not os.path.exists(db_filename):
    print("Downloading Chinook database...")
    # Create unverified SSL context to prevent certificate error
    ssl_context = ssl._create_unverified_context()
    
    with urllib.request.urlopen(url, context=ssl_context) as response, open(db_filename, 'wb') as out_file:
        out_file.write(response.read())
        
    print("Database downloaded successfully as chinook.db!")
else:
    print("chinook.db already exists.")