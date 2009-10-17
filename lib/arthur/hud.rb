# anything that needs to be drawn as an on screen display (e.g. health bars, inventory)
module Artventure::Hud
  
  class FPSCounter
    include Sprite
    attr_reader :fps

    def initialize(game, x, y)
      super
      @current_second = Gosu::milliseconds / 1000
      @accum_fps = 0
      @fps = 0
    end

    def register_tick
      @accum_fps += 1
      current_second = Gosu::milliseconds / 1000
      if current_second != @current_second
        @current_second = current_second
        @fps = @accum_fps
        @accum_fps = 0
      end
    end
    
    def draw
      register_tick
      game.resources.font(:default).draw("FPS #{fps}", x, y, 1, 1.0, 1.0, 0xffffff00)
    end
  end  
  
  
  class StatsBox
    include Sprite
    
    image "items/statsbox.png"
    
    def initialize(game)
      super
      @color = game.resources.color("80ffffff")
    end
    
    def draw
      image.draw(0, 0, 0, 1, 1, @color)
    end
  end
  
  
  class AttributeBar
    include Sprite
    
    def initialize(game, x, y, color, player, attribute_name)
      super
      @player = player
      @attribute_name = attribute_name
      @normal_color = color
      @anti_color = @resources.color(248, 251, 4)
    end
    
    def draw
      attribute = @player.attributes[@attribute_name.to_sym]
      (0..5).each do |i|
        game.draw_line(x, y + i, @anti_color, attribute.max + 10, 110, @anti_color, 0)
        # maybe use a gradient here
        game.draw_line(x, y + i, @normal_color, attribute.value + 10, 110, @normal_color, 0)
      end
    end
  end
end