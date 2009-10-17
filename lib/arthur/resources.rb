# cache images to make sure image is only once in memory
# Use like: image = Resource['items/gold3']
class Artventure::Resources
  ALL = {}
  TYPES = [:images, :songs, :sfx, :colors, :frames, :tiles, :fonts]
  TYPES.each{|type| ALL[type] = {} }
  
  DEFAULT_COLORS = {
    :red   => "ff0000",
    :green => "00ff00",
    :blue  => "0000ff",
    :black => "000000",
    :white => "ffffff"
  }
  
  DEFAULT_FONT_SIZES[] = {
    :default => 20,
    :small   => 14,
    :title   => 45,
    :credits => 30
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
  
  def image(filename, option_flag = false)
    ALL[:images][filename] ||= load_image(filename, option_flag)
  end

  def frames(filename, width, height, option_flag = false)
    ALL[:frames] ||= load_frames(filename, width, height, option_flag)
  end

  def tiles(filename, width, height, option_flag = true)
    ALL[:tiles] ||= load_frames(filename, width, height, option_flag)
  end
  
  def song(filename, volume = nil)
    ALL[:songs][filename] ||= load_song(filename, volume)
  end

  def sfx(filename, options = nil)
    ALL[:sfx][filename] ||= load_sfx(filename, options)
  end

  def font(name, type = nil)
    type = Gosu::default_font_name if type.nil?
    ALL[:fonts][name] ||= load_font(DEFAULT_FONT_SIZES[name], type)
  end  

  def color(red, green = nil, blue = nil, alpha = 255)
    ALL[:colors][hex_for_rgb(red, green, blue)] ||= load_color(red, green, blue, alpha)
  end

  # Convenience methods
  def background(filename)
    image("backgrounds/#{filename}", true)
  end
  
  # These methods should not be used directly (they will reload the image, instead of getting them out of the cache ALL)
  def load_image(filename, option_flag = false)
    Image.new(@window, DATA_PATH+'/'+filename, option_flag)
  end

  def load_frames(filename, width, height, option_flag)
    if width and height
      frames = Image.load_tiles(@window, "#{DATA_PATH}/#{filename}", width, height, option_flag)
    else
      frames = [load_image(filename)] # TODO: check if option_flag for Image.new and Image.load_tiles is the same
    end
  end
  
  def load_song(filename, volume = nil)
    path = (filename =~ '\.ogg$') ? "OGG" : "Midi"
    song = Gosu::Song.new(@window, "#{DATA_PATH}/music/#{path}/#{filename}")
    song.volume = volume if volume
    song
  end
  
  # TODO: see if there's a usage for options, else remove it from arguments
  def load_sfx(filename, options)
    Gosu::Sample.new(@window, "#{DATA_PATH}/sfx/#{filename}")  
  end
  
  def load_color(red, green, blue, alpha)
    alpha = alpha.is_a?(Numeric) ? alpha.to_s(16) : alpha.to_s
    if green.nil? && blue.nil?
      alpha = (red.size == 6) ? "ff" : ""
      # either red contains the whole rgb value as a string in hex format OR the color as a symbol (e.g. :red)
      red.is_a?(Symbol) ? DEFAULT_COLORS[red] : Gosu::Color.new("#{alpha}#{red}".hex)
    else
      Gosu::Color.new(alpha, red, green, blue)
    end
  end
  
  def load_font(size, name = Gosu::default_font_name)
    Gosu::Font.new(@window, name, size)
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