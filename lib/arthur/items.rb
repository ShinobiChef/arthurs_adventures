# TODO: assign images to corresponding Sprites declaratively
#
# @spritembox = Resource["items/statsbox.png", true]
# @sprstatsbanner = Resource["data/backgrounds/statsbanner.png", true]
# gold_img = Resource['items/gold3']

# shop_img = Image.new(window, "data/items/wizardred.png", false)
# helmet_img = Image.new(window, "data/items/helmet.png", false)
# firecrystal_img = Image.new(window, "data/items/crystalfire.png", false)
# firebook_img = Image.new(window, "data/items/bookfire.png", false)
# icecrystal_img = Image.new(window, "data/items/crystalice.png", false)
# icebook_img = Image.new(window, "data/items/bookice.png", false)
# lightningcrystal_img = Image.new(window, "data/items/crystallightning.png", false)
# lightningbook_img = Image.new(window, "data/items/booklightning.png", false)
# earthcrystal_img = Image.new(window, "data/items/crystalearth.png", false)
# earthbook_img = Image.new(window, "data/items/bookground.png", false)
# sign_img = Image.new(window, "data/items/sign2-small.png", false)
# evilbook_img = Image.new(window, "data/items/bookevil.png", false)
# swordsandgreyshield_img = Image.new(window, "data/items/2swordsandgreyshield.png", false)
# tree1_img = Image.new(window, "data/items/tree1.png", false)
# tree2_img = Image.new(window, "data/items/tree2.png", false)
# tree3_img = Image.new(window, "data/items/tree3.png", false)
# tree4_img = Image.new(window, "data/items/tree4.png", false)
# groundareagate_img = Image.new(window, "data/items/caveofground.png", false)
# house1_img = Image.new(window, "data/items/house1.png", false)
# greenpotion_img = Image.new(window, "data/items/largegreenpotion.png", false)
# bluepotion_img = Image.new(window, "data/items/largebluepotion.png", false)
# redpotion_img = Image.new(window, "data/items/largeredpotion.png", false)
# goldpotion_img = Image.new(window, "data/items/largegoldpotion.png", false)
# 
# fire_img = Image.new(window, "data/enemys/fire.png", false)
# snake_img = Image.new(window, "data/enemys/snake.png", false)
# 
# checkpoint_img = Image.new(window, "data/items/skullcheckpoint.png", false)
# greyshield_img = Image.new(window, "data/items/greyshield.png", false)
# powerupsword_img = Image.new(window, "data/items/powerupsword2.png", false)


# TODO: maybe rename to Equipment
class Collectable
  include Sprite
end


class Gold < Collectable
  IMAGE = 'items/gold3'  
end


# TODO: refactor below like Gold class above
# test, test, test

class CollectibleGold
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
    animate(:nothing, screen_x, screen_y)
  end
end

class Collectibleshop
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


class Collectiblehelmet
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

class Collectiblefirecrystal
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

class Collectiblefirebook
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

class Collectibleicecrystal
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

class Collectibleicebook
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

class Collectiblelightningcrystal
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

class Collectiblelightningbook
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

class Collectibleearthcrystal
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

class Collectibleearthbook
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


class Sign
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

class Collectibleevilbook
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

class Collectibleswordsandgreyshield
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


class Collectibletree2
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


class Collectibletree3
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


class Collectibletree4
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

class Collectiblegroundareagate
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


class Collectiblehouse1
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

class Collectiblebluepotion
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

class Collectiblegreenpotion
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

 class Collectibleredpotion
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
 
 class CollectibleGoldPotion
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

class Collectiblegreyshield
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
 