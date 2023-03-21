require 'artists_repository'

RSpec.describe ArtistsRepository do
   def reset_artists_table
        seed_sql = File.read('spec/seeds_artists.sql')
        connection = PG.connect({host: '127.0.0.1', dbname: 'music_library_test'})
        connection.exec(seed_sql)
   end
  
        before(:each) do
            reset_artists_table
        end
   
    it 'Test artists table' do
        repo = ArtistsRepository.new
        artists = repo.all
        expect(artists.length).to eq (2)
        expect(artists.first.id).to eq ('1')
        expect(artists.first.name).to eq('Pixies')
        expect(artists.first.genre).to eq('Rock')
        expect(artists[1].id).to eq ('2')
    end
    it 'finds a single artist' do
        repo = ArtistsRepository.new
        artists = repo.find(1)
        expect(artists.id).to eq ('1')
        expect(artists.name).to eq('Pixies')
        expect(artists.genre).to eq('Rock')
    end
end
