require 'albums_repository'

RSpec.describe AlbumsRepository do
   def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({host: '127.0.0.1', dbname: 'music_library_test'})
        connection.exec(seed_sql)
   end
  
        before(:each) do
            reset_albums_table
        end
   
    it 'Test artists table' do
        repo = AlbumsRepository.new
        albums = repo.all
        expect(albums.length).to eq (2)
        expect(albums.first.id).to eq ('1')
        expect(albums.first.title).to eq('Doolittle')
        expect(albums.first.release_year).to eq('1989')
        expect(albums.first.artist_id).to eq('1')
    end
    it 'finds a single album' do
        repo = AlbumsRepository.new
        albums = repo.find(1)
        expect(albums.id).to eq ('1')
        expect(albums.title).to eq('Doolittle')
        expect(albums.release_year).to eq('1989')
        expect(albums.artist_id).to eq('1')
    end
end
