# cache images to make sure image is only once in memory
# Use like: image = Resource['items/gold3']
class Artventure::Resources
  ALL = {}
  TYPES = [:image, :song, :sfx, :color]
  TYPES.each{|type| ALL[type] = {} }
  
  DEFAULT_COLORS = {
    :red   => "ff0000",
    :green => "00ff00",
    :blue  => "0000ff",
    :black => "000000",
    :white => "ffffff"
  }
  
  def initialize(window)
    @window = window
  end
  
  def [](filename, options)
    case filename
    when /\.(ogg|midi?)$/
      song(filename, options)
    when /\.(wav|mp3)$/
      sfx(filename, options)
    else
      image(filename, options)
    end
  end
  
  def image(filename, image_options = false)
    ALL[:image][filename] ||= load_image(filename, image_options)
  end
  
  def song(filename, volume = nil)
    ALL[:song][filename] ||= load_song(filename, volume)
  end

  def sfx(filename, options = nil)
    ALL[:sfx][filename] ||= load_sfx(filename, options)
  end

  def color(red, green = nil, blue = nil)
    ALL[:color][hex_for_rgb(red, green, blue)] ||= load_color(red, green, blue)
  end

  # Convenience methods
  def background(filename)
    image("backgrounds/#{filename}", true)
  end
  
  
  # These methods should not be used directly (they will reload the image, instead of getting them out of the cache ALL)
  def load_image(filename, image_options = false)
    Image.new(@window, DATA_PATH+'/'+filename, image_options)
  end

  def load_song(filename, volume = nil)
    path = (filename =~ '\.ogg$') ? "OGG" : "Midi"
    song = Gosu::Song.new(@window, "#{DATA_PATH}/music/#{path}/#{filename}")
    song.volume = volume if volume
    song
  end
  
  def load_sfx(filename, options)
    Gosu::Sample.new(@window, "#{DATA_PATH}/sfx/#{filename}")  
  end
  
  def load_color(red, green, blue)
    if green.nil? && blue.nil?
      # either red contains the whole rgb value as a string in hex format OR the color as a symbol (e.g. :red)
      red.is_a?(Symbol) ? DEFAULT_COLORS[red] : Gosu::Color.new("ff#{red}".hex)
    else
      Gosu::Color.new(255, red, green, blue)
    end
  end
  
  
  private
  
  def hex_for_rgb(red, green, blue)
    if green.nil? && blue.nil? && !red.is_a?(Numeric)
      red
    else
      red.to_s(16) + green.to_s(16)} + blue.to_s(16)
    end
  end
end


