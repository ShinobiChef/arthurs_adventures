# A player controlled or cpu-controlled creature on the screen
class Artventure::Creature
  include Sprite
  include Attribute::Accessors
  
  class_attribute :health, :mana

  attr_reader :attributes

  def initialize(game, x = nil, y = nil)
    @attributes = {
      :health => Attribute.new("Health", self.class.class_attributes[:health] || 1),
      :mana   => Attribute.new("Mana", self.class.class_attributes[:mana] || 0)
    }
    super
  end
  
  # TODO: maybe let Inventory class handle the destroying
  def destroy_used_up_items!
    #@items.reject{|name, item|, }
  end

  def apply_effect(name)
    Effect.new(creature, name).apply!
  end
end


# All creatures in the game
module Artventure::Creatures
  
  class Fire < Creature
    image "enemys/fire.png"
    health 100
  end

  class Snake < Creature
    image "enemys/snake.png"
    health 10
    
    def draw(screen_x, screen_y)
      # TODO: is this what the method does: Draw, slowly rotating?
      # TODO: maybe add this to the animation method of Sprite
      image.draw_rot(@x - screen_x + (1 * Math.sin(thisTime / 100.7)), @y - screen_y, 0, 0)
    end
  end


end