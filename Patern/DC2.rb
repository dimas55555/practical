# Компонент - базовий клас для музичного плеєра
class MusicPlayer
  def play
    # Логіка відтворення музики
    raise NotImplementedError, 'Потрібно реалізувати метод play у підкласах'
  end
end

# Конкретний компонент - музичний файл
class MusicFile < MusicPlayer
  def initialize(filename)
    @filename = filename
  end

  def play
    puts "Відтворення музичного файлу: #{@filename}"
  end
end

# Декоратор - базовий клас декоратора для збереження та завантаження даних
class DataDecorator < MusicPlayer
  def initialize(music_player)
    @music_player = music_player
  end

  def play
    @music_player.play
  end
end

# Конкретний декоратор - збереження у форматі MP3
class MP3Decorator < DataDecorator
  def save
    puts "Збереження у форматі MP3: #{@filename}.mp3"
  end
end

# Конкретний декоратор - збереження у форматі WAV
class WAVDecorator < DataDecorator
  def save
    puts "Збереження у форматі WAV: #{@filename}.wav"
  end
end

# Використання
music_file = MusicFile.new("song")
mp3_player = MP3Decorator.new(music_file)
wav_player = WAVDecorator.new(music_file)

mp3_player.play  # Відтворення музичного файлу: song
mp3_player.save  # Збереження у форматі MP3: song.mp3

wav_player.play  # Відтворення музичного файлу: song
wav_player.save  # Збереження у форматі WAV: song.wav

puts"\n"
music_file2 = MusicFile.new("song2")
mp3_player2 = MP3Decorator.new(music_file2)

mp3_player2.play  # Відтворення музичного файлу: song
mp3_player2.save  # Збереження у форматі MP3: song.mp3