# TODO: assign images below to corresponding Sprites declaratively, e.g. image "items/wizardred.png"
#
# @sprstatsbanner = Resource["data/backgrounds/statsbanner.png", true]

# Items are collectables that are not constantly active or have to be equipped and usually get destroyed after use
module Artventure::Item
  attr_reader :destroyed

  # returns true if it should be destroye
  def use(creature)
    effect!(creature) unless destroyed?
  end

  def destroyed?
    @destroyed ||= false
  end

  def destroy!
    @destroyed = true
  end
end


module Artventure::Inventory
  # TODO: maybe create class Inventory to hold all this stuff (i.e. each creature has an inventory for loot and own usage)

  # Collectables
  # collectables are not usable, but get picked up and add something...
  class Gold < Collectable
    image 'items/gold3'
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
  
end 