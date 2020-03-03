class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    artist, song, genre = filename.gsub(".mp3", "").split(" - ")
    new_song = Song.find_or_create_by_name(song)
    new_artist = Artist.find_or_create_by_name(artist)
    new_genre = Genre.find_or_create_by_name(genre)
    new_song.artist = new_artist
    new_song.genre = new_genre
    new_song
  end

  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
    song.save
    song
  end
end
