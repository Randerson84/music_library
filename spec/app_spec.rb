require './app'

RSpec.describe Application do
    context " Testing the App.rb" do
        it "output the list of albums" do
            io = double :io
            expect(io).to receive(:puts).with("Welcome to the music library manager! \n \n").ordered
            expect(io).to receive(:puts).with("What would you like to do? \n").ordered
            expect(io).to receive(:puts).with("1 - List all albums \n").ordered
            expect(io).to receive(:puts).with("2 - List all artists \n").ordered
            expect(io).to receive(:puts).with("Enter your choice:").ordered
            expect(io).to receive(:gets).and_return("1").ordered
            expect(io).to receive(:puts).with("Here is the list of albums: \n").ordered
            album = AlbumsRepository.new
            artist = ArtistsRepository.new
            app = Application.new('music_library', io, album, artist)
            expect(app.run).to eq "1 - Doolittle\n2 - Surfer Rosa\n3 - Waterloo\n4 - Super Trouper\n5 - Bossanova\n6 - Lover\n7 - Folklore\n8 - I Put a Spell on You\n9 - Baltimore\n10 - Here Comes the Sun\n11 - Fodder on My Wings\n12 - Mezzanine\n13 - Dont Stop Believin\n"
        end
        it "output the list of artists" do
            io = double :io
            expect(io).to receive(:puts).with("Welcome to the music library manager! \n \n").ordered
            expect(io).to receive(:puts).with("What would you like to do? \n").ordered
            expect(io).to receive(:puts).with("1 - List all albums \n").ordered
            expect(io).to receive(:puts).with("2 - List all artists \n").ordered
            expect(io).to receive(:puts).with("Enter your choice:").ordered
            expect(io).to receive(:gets).and_return("2").ordered
            expect(io).to receive(:puts).with("Here is the list of artists: \n").ordered
            album = AlbumsRepository.new
            artist = ArtistsRepository.new
            app = Application.new('music_library', io, album, artist)
            expect(app.run).to eq "1 - Pixies\n2 - ABBA\n3 - Taylor Swift\n4 - Nina Simone\n5 - Massive Attack\n6 - Journey\n"
        end
    end
end