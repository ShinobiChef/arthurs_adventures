# A player controlled or cpu-controlled creature on the screen
class Artventure::Creature
  include Sprite
  include Attribute::Accessors
  
  class_attribute :health, :mana

  attr_reader :attributes, :inventory, :effects

  def initialize(game, x = nil, y = nil)
    super
    max_health = self.class.class_attributes[:health] || 1
    max_mana   = self.class.class_attributes[:mana] || 0

    @attributes = { :health => Attribute.new("Health", max_health), :mana => Attribute.new("Mana", max_mana) }
    @inventory = Inventory.new(game, self)
    @effects = []
  end
  
  def lifecycle!
    apply_timed_effects!
    # TODO: check collisions for each creature?
  end
  
  def apply_effect(name)
    Effect.new(creature, name).apply!
  end
  
  def apply_timed_effects!
    @effects.each do |effect|
      effect.apply! if effect.ready?
    end
  end
end


# All creatures in the game
module Artventure::Creatures

  class Arthur
    attr_reader :level
    
    def initialize(game, x, y)
      super
      @attributes = {}
    end
  end
  
  
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