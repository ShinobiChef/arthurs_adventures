module Artventure::Prop
  include Sprite
  
end

module Artventure::Props
  class Shop < Prop
    image "items/wizardred.png"
  end

  class Sign < Prop
    image "items/sign2-small.png"
  end

  class House1 < Prop
    image "items/house1.png"
  end

  class GroundAreaGate < Prop
    image "items/caveofground.png"
  end

  class CheckpointSkull < Prop
    image "items/skullcheckpoint.png"
  end


  class Tree1 < Prop
    image "items/tree1.png"
  end

  class Tree2 < Prop
    image "items/tree2.png"
  end

  class Tree3 < Prop
    image "items/tree3.png"
  end

  class Tree4 < Prop
    image "items/tree4.png"
  end


 
  # Dust particle class draws "smoke" at the given position with 
  # a given lifespan. The lifespan shares a value with alpha
  # so as the life decreases, so does the visibility.
  class DustParticle < Prop
    image "arthur/dust2.png"
 
    def initialize(game, x, y, lifespan)
      @lifespan = lifespan
      super

      # make the color "brownish" corresponding to the tile
      @color = game.resources.color(255, 190, 100)

      @lifespan = 255 if @lifespan > 255
      @color.alpha = @lifespan
    end
 
    def draw(screen_x, screen_y)
      if @lifespan > 1
        image.draw(@x - screen_x - 10, @y - screen_y - 15, 0, 1, 1, @color)
      end
    end
 
    def update
      @lifespan -= 1
      @lifespan = 0 if @lifespan < 0
      
      @color.alpha = @lifespan
    end
 
    def remove?
      @lifespan <= 0
    end
  end
  
end