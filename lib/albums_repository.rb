require_relative './albums'

class AlbumsRepository
    # Selecting all records
    # No arguments
    def all
    # Executes the SQL query:
    # select id, name, genre from artists;
        sql = 'SELECT id, title, release_year, artist_id FROM albums;'
        result_set = DatabaseConnection.exec_params(sql, [])

        albums = []

        result_set.each do |record|
            album = Albums.new
            album.id = record['id']
            album.title = record['title']
            album.release_year = record['release_year']
            album.artist_id = record['artist_id']
            albums << album
        end

        return albums
    end
    def find(id)
        sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
        param = [id]
        result_set = DatabaseConnection.exec_params(sql, param)

        record = result_set[0]
        album = Albums.new
        album.id = record['id']
        album.title = record['title']
        album.release_year = record['release_year']
        album.artist_id = record['artist_id']
        return album
    end
end