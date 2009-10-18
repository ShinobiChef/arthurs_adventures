# visible on the screen with x and y coordinates and images
module Artventure::Sprite
  include ClassAttributes
  class_attribute :image, :width, :height

  # can be overwritten in classes that include Sprite
  INIT_TIME = Gosu::milliseconds

  attr_accessor :x, :y, :current_area, :frames
    
  
  # provide relative coordinates, not pixel (e.g. 2 instead of 100 when SQUARE_SIZE is 50)
  def initialize(game, x, y)
    # these values are set in the class definition of classes including Sprite (see class_attributes.rb)
    image  = self.class.class_attributes[:image]
    width  = self.class.class_attributes[:width]
    height = self.class.class_attributes[:height]
    
    @game = game
    @x, @y = x, y
    @frames = game.resources.frames(image, width, height)
    
    # add a delay to the time so they move differently
    @delay = rand(100) + 1
  end

  def image
    # standing is the default representation of the sprite
    @frames.first
  end


  # draw(x, y, z, factor_x=1, factor_y=1, color=0xffffffff)
  # 
  # TODO: find out what screen_x and screen_y is for and try to remove it from the method params and make it e.g. a constant
  def draw(screen_x, screen_y)
    animate(:nothing, screen_x, screen_y)
  end
  
  # give either a single sprite or an array
  def colliding_with?(sprite)
    (sprite.x - x).abs < Map::SQUARE_SIZE / 2 and (sprite.y - y).abs < Map::SQUARE_SIZE
  end

  # TODO: maybe renamed other similar methods to handle_ for consistency
  def handle_collision!(sprite)
    # Default: do nothing
  end
  
  protected

  def game
    @game
  end
  
  # About draw_rot(x, y, z, angle, center_x=0.5, center_y=0.5, factor_x=1, factor_y=1, color=0xffffffff, mode=:default)
  # ----------------------------------------------------------------------
  # center_x: Relative horizontal position of the rotation center on the image.
  # 0 is the left border, 1 is the right border, 0.5 is the center (and default)
  # the same applies to center_y, respectively.
  # 
  def animate(animation, screen_x, screen_y)
    case animation
    when :rotate_slowly
      image.draw_rot(x - screen_x, y - screen_y + (5 * Math.sin(thisTime / 133.7)), 0, 0)
    when :nothing, nil
      image.draw_rot(x - screen_x, y - screen_y, 0, 0)      
    end
  end

  # thisTime is the golds own independant time so they all move differently.
  # Quite handy in independant animations like on-the-spot explosions.
  def thisTime
    Gosu::milliseconds - INIT_TIME / @delay
  end

  def relative_to_absolute(x)
    x * Map::SQUARE_SIZE + (Map::SQUARE_SIZE / 2)
  end
      
end