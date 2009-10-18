# IDEA: give gold and potions weight. 
# maybe allow money notes or something later to carry more gold in a lighter way
class Artventures::Collectable
  include Sprite

  class_attributes :sound, :name, :weight, :worth

  def initialize(game, x, y)
    super
    @sound = game.resources.sfx(self.class.class_attributes[:sound])
  end
  
  def name
    self.class.class_attributes[:name] || self.class.name
  end

  def weight
    self.class.class_attributes[:weight] || 0
  end

  def worth
    self.class.class_attributes[:worth] || 0
  end
  
  
  def collected?
    @collected
  end
  
  def collected!
    @sound.play
    @collected = true
    # TODO: maybe set x, y to nil? but maybe not really necessary    
  end
  
  
end


module Artventure::Collectables
  # TODO: maybe create class Inventory to hold all this stuff (i.e. each creature has an inventory for loot and own usage)

  # Collectables
  # collectables are not usable, but get picked up and add something...
  class Gold < Collectable
    image 'items/gold3'
    sound ''
  end


  # Items
  class RedPotion < Item
    image "items/largeredpotion.png"
    
    def effect!(creature)
      destroy! if creature.apply_effect(:restore_health)
    end    
  end

  class BluePotion < Item
    image "items/largebluepotion.png"

    def effect!(creature)
      destroy! if creature.apply_effect(:restore_mana)
    end
  end

  class GoldPotion < Item
    image "items/largegoldpotion.png"
    
    def effect!(creature)
      destroy! if creature.apply_effect(:restore_health) | creature.apply_effect(:restore_mana)      
    end
  end

  class GreenPotion < Item
    image "items/largegreenpotion.png"
    
    def effect!(creature)
      destroy! if creature.apply_effect(:restore_status)      
    end
  end

  # gets destroyed after second use
  class LargePotion < Item
    # TODO: get other image for large potions
    image "items/largeredpotion.png"
    
    def effect!(creature)
      @doses ||= 2
      creature.apply_effect(:restore_health)
      @doses -= 1
      destroy! if @doses == 0
    end
  end
  
end