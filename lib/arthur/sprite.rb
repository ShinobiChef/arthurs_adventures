module Artventure
  
  # visible on the screen with x and y coordinates and images
  module Sprite
    # can be overwritten in classes that include Sprite
    INIT_TIME = Gosu::milliseconds
  
    attr_accessor :x, :y, :image, :currentarea
    
        
    # provide relative coordinates, not pixel (e.g. 2 instead of 100 when SQUARE_SIZE is 50)
    def initialize(window, x, y)
      @image = Resource[IMAGE, window]
      @x, @y = to_absolute(x), to_absolute(y)
      # add a delay to the time so they move differently
      @delay = (rand 100) + 1
    end
  
  
    def draw(screen_x, screen_y)
      animate(:nothing, screen_x, screen_y)
    end


    protected

    def animate(animation, screen_x, screen_y)
      case animation
      when :rotate_slowly
        @image.draw_rot(@x - screen_x, @y - screen_y + (5 * Math.sin(thisTime / 133.7)), 0, 0)
      when nil || :nothing
        @image.draw_rot(@x - screen_x, @y - screen_y, 0, 0)      
      end
    end

    # thisTime is the golds own independant time so they all move differently.
    # Quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - INIT_TIME / @delay
    end

    def to_absolute(x)
      x * MAP::SQUARE_SIZE + (MAP::SQUARE_SIZE / 2)
    end
        
  end
  
end