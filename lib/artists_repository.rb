require_relative './artists'

class ArtistsRepository
    # Selecting all records
    # No arguments
    def all
    # Executes the SQL query:
    # select id, name, genre from artists;
        sql = 'SELECT id, name, genre FROM artists;'
        result_set = DatabaseConnection.exec_params(sql, [])

        artists = []

        result_set.each do |record|
            artist = Artists.new
            artist.id = record['id']
            artist.name = record['name']
            artist.genre = record['genre']
            artists << artist
        end

        return artists
    #returns an array of Artists objects.
    end
    def find(id)
        sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
        param = [id]
        result_set = DatabaseConnection.exec_params(sql, param)

        record = result_set[0]
        artist = Artists.new
        artist.id = record['id']
        artist.name = record['name']
        artist.genre = record['genre']
        return artist
    end
end