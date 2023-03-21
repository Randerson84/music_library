# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/artists_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library_test')

# Perform a SQL query on the database and get the result set.
artists_repository = ArtistsRepository.new

artists_repository.all.each do |artist|
  p artist
end
# Print out each record from the result set .
