class MusicLibraryController

  def initialize(path = './db/mp3s')
    imported = MusicImporter.new(path)
    imported.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip

    case input
    when "exit"
      return
    when 'list songs'
      list_songs
    when 'list artists'
      list_artists
    when 'list genres'
      list_genres
    when 'list artist'
      list_songs_by_artist
    when 'list genre'
      list_songs_by_genre
    when 'play song'
      play_song
    else
      call
    end

  end

  def list_songs
    Song.all.sort_by{|s| s.name}.uniq.each_with_index do |song, idx|
      puts "#{idx+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by{|a| a.name}.each_with_index do |artist, idx|
      puts "#{idx+1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by{|g| g.name}.each_with_index do |genre, idx|
      puts "#{idx+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip

    if artist = Artist.find_by_name(input)
      artist.songs.sort_by{|s| s.name}.each_with_index do |song, idx|
        puts "#{idx+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

    if genre = Genre.find_by_name(input)
      genre.songs.sort_by{|s| s.name}.each_with_index do |song, idx|
        puts "#{idx+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    if input > 0 && input <= Song.all.uniq.length
      songs = Song.all.sort_by{|s| s.name}.uniq
      song = songs[input-1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
