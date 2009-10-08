class FPSCounter
  attr_reader :fps

  def initialize
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
end

class Collectiblegold
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
 
 class Collectiblegoldpotion
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
  end
end

class Collectiblepowerupsword
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
    @image.draw_rot(@x - screen_x, @y - screen_y+5 * Math.sin(thisTime / 133.7), 0,
      0)
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
    # Draw, slowly rotating
    @image.draw_rot(@x - screen_x, @y - screen_y, 0,
      0)
  end
end

class Hitablesnake
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
 
 def update
   #hit_by?(dagger)
   
   end
 
  def draw(screen_x, screen_y)
    # Draw, slowly rotating
    @image.draw_rot(@x - screen_x+1 * Math.sin(thisTime / 100.7), @y - screen_y, 0,
      0)
    end
    
    def hit_by?(dagger)
    #if Gosu::distance(dagger.x, dagger.y, @x, @y) < 30 then
    if Gosu::distance(dagger.x, dagger.y, @x - screen_x+1 * Math.sin(thisTime / 100.7), @y - screen_y) < 30 then  
      # Was hit :)
      snakes.reject!
      $hitsound.play
      return true
    else
      return false
    end    
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
 