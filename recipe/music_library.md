1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

Skipping this since database already created.

2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.
```sql

-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES ('ABBA', 'Pop');

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Doolittle', '1989', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Waterloo', '1974', '2');
```
```bash
psql -h 127.0.0.1 music_library_test < spec/seeds_artists.sql
psql -h 127.0.0.1 music_library_test < spec/seeds_albums.sql
```

3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.
```ruby
# EXAMPLE
# Table name: artists

# Model class
# (in lib/artists.rb)
class Artists

end

# Repository class
# (in lib/artists_repository.rb)
class ArtistsRepository

end
# EXAMPLE
# Table name: albums

# Model class
# (in lib/albums.rb)
class Albums

end

# Repository class
# (in lib/albums_repository.rb)
class AlbumsRepository

end

```
4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.
```ruby 
# Model class
# (in lib/artists.rb)
class Artists
    attr_accessor :id, :name, :genre
end
# Model class
# (in lib/albums.rb)
class Albums
    attr_accessor :id, :title, :release_year, :artist_id
end
```
5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.
```ruby
# EXAMPLE
# Table name: artists

# Repository class
# (in lib/artists_repository.rb)
class ArtistsRepository
    # Selecting all records
    # No arguments
    def all
    # Executes the SQL query:
    # select id, name, genre from artists;

    #returns an array of Artists objects.
    end
    # selects a single record
    # given the id as an arg
    def find(id)
    # select id, name, genre from artists where id = $1;

    #returns one artist.
    end
end
```
6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all artists

repo = ArtistsRepository.new

artists = repo.all

artists.length # =>  2

artists[0].id # =>  1
artists[0].name # =>  'Pixies'
artists[0].genre # =>  'Rock'

artists[1].id # =>  2
artists[1].name # =>  'ABBA'
artists[1].genre # =>  'Pop'

# 2
# Get a single artists

repo = ArtistsRepository.new

artists = repo.find(1)

artists.id # =>  1
artists.name # =>  'Pixies'
artists.genre # =>  'Rock'

# 1
# Get all albums

repo = AlbumsRepository.new

albums = repo.all

albums.length # =>  2

albums[0].id # =>  1
albums[0].title # =>  'Doolittle'
albums[0].release_year # =>  1989
albums[0].artist_id # =>  1

albums[1].id # =>  2
albums[1].title # =>  'Waterloo'
albums[1].release_year # =>  1974
albums[1].artist_id # =>  2

# 2
# Get a single albums

repo = albumsRepository.new

albums = repo.find(1)

albums.id # =>  1
albums.title # =>  'Doolittle'
albums.release_year # =>  1989
albums.artist_id # =>  1

# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour