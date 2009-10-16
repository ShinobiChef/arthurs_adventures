# A player controlled or cpu-controlled creature on the screen
# TODO: health will be of class Attribute, and rename to health and mana
module Artventure
end
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


# TODO: define all creatures here, but probably move into it's own (or even more than one) file
module Artventure::Creatures
  
  class Snake < Creature
    image  "image_tile_set_location"
    width  50
    height 20
    
    health 10
    
    def initialize(game)
      super(game)
    end
  end
  
end