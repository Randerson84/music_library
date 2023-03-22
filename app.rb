# file: app.rb

require_relative './lib/database_connection'
require_relative './lib/albums_repository'
require_relative './lib/artists_repository'

# Print out each record from the result set .
# file: app.rb

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.
   
    @io.puts "Welcome to the music library manager! \n \n"
    @io.puts "What would you like to do? \n"
    @io.puts "1 - List all albums \n"
    @io.puts "2 - List all artists \n"
    @io.puts "Enter your choice:"
    choice = @io.gets.to_i

    if choice == 1
      @io.puts "Here is the list of albums: \n"
      albums = @album_repository.all
      album_list = String.new
      albums.each_with_index do |member, i|
        album_list << "#{i+1} - #{member.title}\n"
      end
      puts album_list
      return album_list
    elsif choice == 2 
      @io.puts "Here is the list of artists: \n"
      artists = @artist_repository.all
      artist_list = String.new
      artists.each_with_index do |member, i|
        artist_list << "#{i+1} - #{member.name}\n"
      end
      puts artist_list
      return artist_list
    else
      return @io.puts "Invalid Choice"
    end

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumsRepository.new,
    ArtistsRepository.new
  )
  app.run
end