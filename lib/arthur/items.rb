# TODO: assign images below to corresponding Sprites declaratively, e.g. image "items/wizardred.png"
#
# @spritembox = Resource["items/statsbox.png", true]
# @sprstatsbanner = Resource["data/backgrounds/statsbanner.png", true]
# firebook_img = Image.new(window, "data/items/bookfire.png", false)
# icecrystal_img = Image.new(window, "data/items/crystalice.png", false)
# icebook_img = Image.new(window, "data/items/bookice.png", false)
# lightningcrystal_img = Image.new(window, "data/items/crystallightning.png", false)
# lightningbook_img = Image.new(window, "data/items/booklightning.png", false)
# earthcrystal_img = Image.new(window, "data/items/crystalearth.png", false)
# earthbook_img = Image.new(window, "data/items/bookground.png", false)
# evilbook_img = Image.new(window, "data/items/bookevil.png", false)
# swordsandgreyshield_img = Image.new(window, "data/items/2swordsandgreyshield.png", false)
# tree1_img = Image.new(window, "data/items/tree1.png", false)
# tree2_img = Image.new(window, "data/items/tree2.png", false)
# tree3_img = Image.new(window, "data/items/tree3.png", false)
# tree4_img = Image.new(window, "data/items/tree4.png", false)
# groundareagate_img = Image.new(window, "data/items/caveofground.png", false)
# house1_img = Image.new(window, "data/items/house1.png", false)
# 
# fire_img = Image.new(window, "data/enemys/fire.png", false)
# snake_img = Image.new(window, "data/enemys/snake.png", false)
# 
# checkpoint_img = Image.new(window, "data/items/skullcheckpoint.png", false)
# greyshield_img = Image.new(window, "data/items/greyshield.png", false)
# powerupsword_img = Image.new(window, "data/items/powerupsword2.png", false)

module Artventure
  # TODO: maybe create class Inventory to hold all this stuff (i.e. each creature has an inventory for loot and own usage)

  # Collectables
  class Gold < Collectable
    image 'items/gold3'
  end
  
  # TODO: should shop really be a collectable?
  class Shop < Collectable
    image "items/wizardred.png"
  end

  class Sign < Collectable
    image "items/sign2-small.png"
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
  
  # Equipment
  class Helmet < Equipment
    image "items/helmet.png"    
    name   "Leather Helmet"
    type   :helmet
    weight 1
    worth  10
    
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  # TODO: should those crystals and books be Items or Equipment?
  class FireCrystal < Equipment
    image "items/crystalfire.png"
    
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  class FireBook < Equipment
    image "items/crystalfire.png"
    
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  class IceCrystal < Equipment
    image "items/crystalice.png"
    
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  class IceBook < Equipment
    image "items/crystalfire.png"
    
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  class LightningCrystal < Equipment
    image "items/chrystallightning.png"
    
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  class LightningBook < Equipment
    image "items/booklightning.png"
    
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  
  class EarthCrystal < Equipment
    image "items/chrystalearth.png"
    
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end


  # TODO: Refactor classes like above (it's fun, you can kill 90% of the lines)
  class EarthBook
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  class EvilBook
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  class swordsandgreyshield
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  class Bktree1
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end


  class tree2
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end


  class tree3
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end


  class tree4
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end

  class groundareagate
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end


  class house1
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end

  class bluepotion
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end

  class greenpotion
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end


  class Checkpointskull
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end

   class redpotion
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end
 
   class GoldPotion
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x, @y - screen_y, 0,
        0)
    end
  end

  class greyshield
    attr_reader :x, :y

    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
        end
  
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
  
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      animate(:rotate_slowly, screen_x, screen_y)
    end
  end

  class PowerupSword < Collectable
    def initialize(x, y)
      super(Resource["items/powerupsword2.png"], x, y)
    end
  
    def draw(screen_x, screen_y)
      animate(:rotate_slowly, screen_x, screen_y)
    end  
  end

 
  class Hitablefire
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      animation :nothing
    end
  end

  # SNAAAAAKE
  class Hitablesnake
    attr_reader :x, :y
 
    def initialize(image, x, y)
      @image = image
      @x, @y = x, y
      @initTime = Gosu::milliseconds #the the milliseconds when created
      @delay = (rand 100)+1 #add a delay to the time so they move differently
    end
 
    #thisTime is the golds own independant time so they all move differently.
    #quite handy in independant animations like on-the-spot explosions.
    def thisTime
      Gosu::milliseconds - @initTime/@delay
    end
 
    def draw(screen_x, screen_y)
      # Draw, slowly rotating
      @image.draw_rot(@x - screen_x+1 * Math.sin(thisTime / 100.7), @y - screen_y, 0,
        0)
    end
  end


  #Dust particle class draws "smoke" at the given position with 
  #a given lifespan. The lifespan shares a value with alpha
  #so as the life decreases, so does the visibility.
  class DustParticle
    attr_reader :x, :y
 
    def initialize(window, x, y, life)
      @x = x
      @y = y
      @graphic = Image.new(window, "data/arthur/dust2.png", false)
      @lifespan = life
      @color = Gosu::Color.new(0xff000000)
      #make the color "brownish" corresponding to the tile
      @color.red = 255
      @color.green = 190
      @color.blue = 100
 
      amount = 0
 
      if @lifespan > 255 then
        amount = 255
      else
        amount = @lifespan
      end
 
      @color.alpha = amount
    end
 
    def draw(screen_x, screen_y)
      if ( @lifespan > 1 ) then
      @graphic.draw(@x - screen_x-10, @y - screen_y-15, 0, 1,1, @color)
        end
    end
 
    def update
      @lifespan -=1
 
      if @color.alpha > 0 then
        @color.alpha = @lifespan
      else
       @color.alpha = 0
      end
    end
 
    def remove?
      if @lifespan < 1 then
        true
          else
            false
          end
      end
 
  end

end 