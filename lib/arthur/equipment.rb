# Equipment is something you put on which has an permanent effect as long as it's active
class Artventure::Equipment < Collectable
  class_attributes :type

  def type
    self.class.class_attributes[:type]
  end
  
  def draw(screen_x, screen_y)
    # Draw, slowly rotating
    animate(:rotate_slowly, screen_x, screen_y)
  end
end
  
  
# List all collectable Equipment
module Artventure::Inventory
  class Helmet < Equipment
    image "items/helmet.png"    
    name   "Leather Helmet"
    type   :helmet
    weight 1
    worth  10
  end

  # TODO: Give items more descriptive data like Helmet
  class GreyShield < Equipment
    image "items/greyshield.png"
  end

  class PowerupSword < Equipment
    image "items/powerupsword2.png"
  end

  class SwordsAndGreyShield < Equipment
    image "items/2swordsandgreyshield.png"
  end


  # TODO: should those crystals and books be Items or Equipment?
  class FireCrystal < Equipment
    image "items/crystalfire.png"
  end

  class FireBook < Equipment
    image "items/crystalfire.png"
  end

  class IceCrystal < Equipment
    image "items/crystalice.png"
  end

  class IceBook < Equipment
    image "items/crystalfire.png"
  end

  class LightningCrystal < Equipment
    image "items/chrystallightning.png"
  end

  class LightningBook < Equipment
    image "items/booklightning.png"
  end

  class EarthCrystal < Equipment
    image "items/chrystalearth.png"
  end

  class EarthBook < Equipment
    image "items/bookground.png"
  end

  class EvilBook < Equipment
    image "items/bookevil.png"
  end
  
end