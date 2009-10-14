module Artventure


  # visible on the screen with x and y coordinates and images
  module Sprite
    attr_accessor :x, :y, :image, :currentarea
  end
  
  
  # A create has many attributes like health or mana
  # TODO: experience could also be an Attribute
  class Attribute < Struct.new(:name, :value, :max)
  end
  
  # A player controlled or cpu-controlled creature on the screen
  # TODO: health will be of class Attribute, and rename to health and mana
  class Creature < Struct.new(:arthurhp, :arthurmaxhp, :arthurmp, :arthurmaxmp)
    include Sprite
    
  end
  
  
  # Potions and Gold could be Equipment as well as Armor and Weapons
  # IDEA: give gold and potions weight. maybe allow money notes or something later to carry more gold in a lighter way
  class Equipment < Struct.new(:name, :type, :weight, :worth)
    
  end


  # The human player playing the game, not Arthur the hero
  # Will be the base for possibly multiplayer
  class Player < Struct.new(:name, :character)
    # Each Player embodies one character
  end
  
  
  # Player class.
  class Arthur < Creature
                
    attr_reader :selecteditem
                # TODO: probably extract into a method and calculate on the fly: touching?(shop)
    attr_reader :touchingshop
                # TODO: extract lives to Player
    attr_reader :arthurlives
                # TODO: extract into Attribute 
    attr_reader :arthurexp
                # TODO: probably extract into create (each creature can have levels)
    attr_reader :arthurlevel
                # TODO: probably extract into Map
    attr_reader :maplevel         
                # TODO: move to Inventory 
    attr_reader :gold
                # TODO: extract into Equipment
    attr_reader :armourvyweight
                # TODO: move to Inventory as Equipment
    attr_reader :numredpotions,
                :numbluepotions,
                :numgreenpotions,
                :numgoldpotions
                # TODO: extract into Effect or Boost class
    attr_reader :arthurweaponattboost,
                :arthurpsysicaldefenceboost,
                :arthurfiredefenceboost,
                :arthuricedefenceboost,
                :arthurlightningdefenceboost,
                :arthurearthdefenceboost,
                :arthurevildefenceboost,
                :arthurfiremagicboost,
                :arthuricemagicboost,
                :arthurlightningmagicboost,
                :arthurearthmagicboost,
                :arthurevilmagicboost
                # TODO: probably make Checkpoint class (or at least hash)
    attr_reader :checkpointx,
                :checkpointy,
                :checkpointarea
                # TODO: make inventory object and Equipment base class
    attr_reader :arthurweapon1,
                :arthurweapon2,
                :arthurweapon3,
                :arthurweapon4,
                :arthurweapon5,
                :arthurweapon6,
                :arthurarmour1,
                :arthurarmour2,
                :arthurarmour3,
                :arthurarmour4,
                :arthurarmour5,
                :arthurarmour6,
                :arthurboots1,
                :arthurboots2,
                :arthurboots3,
                :arthurboots4,
                :arthurboots5,
                :arthurboots6
                # TODO: make one status object
    attr_reader :arthurpoisoned,
                :arthurstatus1,
                :arthurstatus2,
                :arthurstatus3,
                :arthurstatus4,
                :arthurstatus5,
                :arthurstatus6
                # TODO: probably extract somewhere into
    attr_reader :arthurdamage,
                :arthurhprestore,
                :arthurmprestore
                
  
    def initialize(window, x, y)
      # initialize all Resources (images, songs, sfx)
      @resources = Resources.new(window)
      load_music
      
      # TODO: extract ALL global variables into proper classes (e.g. Creature) as instance variables
      $currentarea = 0
      setnewgamevars

      @vy = 0 # Vertical velocity
      @vx = 0 # Horizontally velocity for wall-jumping goodness
      @wall = 0 # Wall climbing or not
      @map = window.map

      # Load all animation frames
      @standing, @walk1, @walk2, @jump, @wall_climb = *Image.load_tiles(window, "data/arthur/arthurarmourbronze.png", 50, 50, false)
      # This always points to the frame that is currently drawn.
      # This is set in update, and used in draw.
      @cur_image = @standing    

      @sprselecteditembox = Image.new(window, "data/items/selecteditembox2.png", true)
      
      # SFX
      # TODO: move to game.rb
      @beep = Gosu::Sample.new(window, "data/sfx/pickupgold3.wav")
      @pickupgold = Gosu::Sample.new(window, "data/sfx/pickupgold3.wav")
      @pickuphelmet = Gosu::Sample.new(window, "data/sfx/powerup.wav")
      @sword = Gosu::Sample.new(window, "data/sfx/sword.wav")
      @usepotion = Gosu::Sample.new(window, "data/sfx/usepotion.wav")
      @pickuppotion = Gosu::Sample.new(window, "data/sfx/pickuppotion.wav")
      @pickupbook = Gosu::Sample.new(window, "data/sfx/pickupbook.wav")
      @pickupexpsound = Gosu::Sample.new(window, "data/sfx/powerup3.wav")
      @jumpsound = Gosu::Sample.new(window, "data/sfx/jump.wav")
      @hitsound = Gosu::Sample.new(window, "data/sfx/hurt1.wav")
      @teleportgatesound = Gosu::Sample.new(window, "data/sfx/teleportgate.wav")

      @smoke = [] #Captain Ruby should have an array of particles stored. He creates them
              #However there is possibly a more ideal way of doing this but I'm a Ruby newb. :D
      @window = window
    end
 
    def draw(screen_x, screen_y)
      # Flip vertically when facing to the left.
      if $dir == :left then
      offs_x = -25
      factor = 1.2
      else
      offs_x = 25
      factor = -1.2
      end
      @cur_image.draw($x - screen_x  + offs_x, $y - screen_y - 58, 0, factor, 1.2)

      #draw character's smoke too
      @smoke.each { |s| s.draw(screen_x, screen_y) }
      if @selecteditem == 1 then @sprselecteditembox.draw(20, 10, 0) end
      if @selecteditem == 2 then @sprselecteditembox.draw(64, 10, 0) end
      if @selecteditem == 3 then @sprselecteditembox.draw(108, 10, 0) end
      if @selecteditem == 4 then @sprselecteditembox.draw(152, 10, 0) end
    end
 
    def would_fit(offs_x, offs_y)
      # Check at the center/top and center/bottom for map collisions
      if $currentarea == 1 then @map = $area1map end
      if $currentarea == 2 then @map = $area2map end
      if $currentarea == 3 then @map = $area3map end
      if $currentarea == 4 then @map = $area4map end
      if $currentarea == 5 then @map = $area5map end
      if $currentarea == 6 then @map = $area6map end
      if $currentarea == 7 then @map = $area7map end
      if $currentarea == 8 then @map = $area8map end
      if $currentarea == 9 then @map = $area9map end

      if $currentarea == 10 then @map = $fireareamap end
      if $currentarea == 11 then @map = $iceareamap end
      if $currentarea == 12 then @map = $lightningareamap end
      if $currentarea == 13 then @map = $groundareamap end
      if $currentarea == 15 then @map = $evilareamap end


      not @map.solid?($x + offs_x, $y + offs_y) and
      not @map.solid?($x +  offs_x, $y + offs_y - 45)
    end

    def try_to_jump
      if @map.solid?($x, $y + 1) then
        @vy = -@armourvyweight #jump value /Armourvyweight value (the lower the value the higher the jump(note the negitave value)
        @wall = 0 #Not climing walls anymore you monkey
        @jumpsound.play
      end

      if @wall != 0 && @map.solid?($x + @wall, $y)
        @vy = -@armourvyweight #On a wall and jumping? Walljump!Armourvyweight value 
        @vx = 10 * @wall #Set the x velocity according to the direction we face from the wall
        @wall = 0
        @jumpsound.play
      end
    end
 

    def update(move_x)
      # Select image depending on action
      if (move_x == 0)
        @cur_image = @standing
      else 
        @cur_image = (milliseconds / 175 % 2 == 0) ? @walk1 : @walk2
      end
      
      @cur_image = @jump if (@vy < 0)
      
      #if you are wall-climbing, set the image to so
      @cur_image = @wall_climb unless @wall == 0    
 
      # TODO: player a bit with jumping settings to make it a bit more heavy/realistic
      # 
      # Acceleration/gravity
      # By adding 1 each frame, and (ideally) adding vy to y, the player's
      # jumping curve will be the parabole we want it to be.
      @vy += 1 # the lower the value the higher the jump
      
      # Vertical movement
      if @vy > 0
        @vy.times do
           if would_fit(0, 1) 
             $y += 1
             @wall = 0 #The character is jumping, therefore there is no way the character is on a wall.
           else
             @vy = 0
             @wall = 0 # The character is jumping, therefore there is no way the character is on a wall.
           end
        end 
      end
      
      if @vy < 0 then
        (-@vy).times { would_fit(0, -1) ? $y -= 1 : @vy = 0 }
        @wall = 0 # The character is jumping, therefore there is no way the character is on a wall.
      end

      # Directional walking, horizontal movement
      if move_x > 0 then
        $dir = :right
        move_x.times do
          if would_fit(1, 0)
            $x += 1 
          elsif @vy > 1  # If you cannot fit, that means you will most likely be on a wall. So if you are not standing still...   
            @vy /= 2     # dampen the velocity
            @wall = 1    # We move to the right.
            # Create dust particles
            create_dust(-20)
          end
        end
      end
      
      if move_x < 0
        $dir = :left
        move_x.abs.times do
          if would_fit(-1, 0)
            $x -= 1 
          elsif @vy > 1  # If you cannot fit, that means you will most likely be on a wall. So if you are not standing still...
            @vy/=2 #dampen the velocity
            @wall = -1 #We move to the left.
            create_dust
          end
        end
      end
      
      # Now we have to check the x velocity which is used when wall jumping
      # It's pretty much the same as the y velocity
      if @vx > 0
        @vx -= 1
        @vx.times{ $x -= 2 if would_fit(-2, 0) }
      else
        @vx += 1
        @vx.abs.times{ $x += 2 if would_fit(2, 0) }
      end
      
      # TODO: extract smoke somewhere into Effect class and allow attaching to any create or Sprite
      # update the smoke
      @smoke.each { |s| s.update }
      
      # manage the smoke particles
      @smoke.reject! do |s|
      s.remove?
    end

    def setnewgamevars
      $x, $y = x, y
      $dir = :right
      $x, $y = 600, 345
      @checkpointx,@checkpointy,@checkpointarea = 600,345,1
      $gold = 0
      $touchingshop = 0
      #$currentarea = 0
      @selecteditem = 1
      @arthurfiredamage = 0
      $numredpotions, $numbluepotions, $numgreenpotions,  $numgoldpotions = 0,0,0,0
      @arthurhp, @arthurmaxhp, @arthurmp, @arthurmaxmp  = 50,50,20,20
      @arthurweaponattboost  = 0
  
      @arthurweapon1, @arthurweapon2, @arthurweapon3, @arthurweapon4, @arthurweapon5, @arthurweapon6 = 1,0,0,0,0,0
      @arthurarmour1, @arthurarmour2, @arthurarmour3, @arthurarmour4, @arthurarmour5, @arthurarmour6 = 1,0,0,0,0,0
      @arthurboots1, @arthurboots2, @arthurboots3, @arthurboots4, @arthurboots5, @arthurboots6 = 1,0,0,0,0,0
      @arthurstatus1, @arthurstatus2, @arthurstatus3, @arthurstatus4, @arthurstatus5, @arthurstatus6 = 0,0,0,0,0,0
    
      @arthurfiredefenceboost, @arthuricedefenceboost,  @arthurlightningdefenceboost = 0,0,0,0
      @arthurearthdefenceboost, @arthurevildefenceboost, @arthurpsysicaldefenceboost = 0,0,0,0,0

      @arthurfiremagicboost, @arthuricemagicboost, @arthurlightningmagicboost = 0,0,0
      @arthurearthmagicboost, @arthurevilmagicboost = 0,0

      @arthurexp, @arthurlevel, $arthurlives = 0,1,3
      @arthurhprestore, @arthurmprestore ,@arthurpoisoned  = 0,0,0
      @armourvyweight = 18
    end

 
    def useitem
      if @selecteditem == 1  and $numredpotions>0   and @arthurhp!=@arthurmaxhp then @arthurhp=@arthurmaxhp and $numredpotions -= 1 and @usepotion.play end 
      if @selecteditem == 2  and $numbluepotions>0  and @arthurmp!=@arthurmaxmp then @arthurmp=@arthurmaxmp and $numbluepotions -= 1 and @usepotion.play end 
  
      if @selecteditem == 3  and $numgoldpotions>0  then  if @arthurhp!=@arthurmaxhp or @arthurmp!=@arthurmaxmp  or @arthurstatus5!=0 then @arthurhp=@arthurmaxhp and @arthurmp=@arthurmaxmp and @arthurstatus5=0 and $numgoldpotions -= 1 and @usepotion.play end end
  
      if @selecteditem == 4  and $numgreenpotions>0   and @arthurstatus5!=0 then @arthurstatus5=0  and @usepotion.play and $numgreenpotions -= 1 end 
    end
  
    def changeitemforward
      @selecteditem += 1
      if @selecteditem > 4 then @selecteditem = 1 end
    end
 
    def changeitembackward
      @selecteditem -= 1
      if @selecteditem < 1 then @selecteditem = 4 end
    end


    # START collect_
    def collect_golds(golds)
       golds.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @pickupgold.play and $gold += 100
      end
    end

    def collect_shops(shops)
      shops.each do |c|
        (c.x - $x).abs < 35 and (c.y - $y).abs < 35 and $touchingshop = 1  
      end 
    end

    def collect_helmets(helmets)
      helmets.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @pickuphelmet.play and $arthurlives += 1
      end
    end

    def collect_firecrystals(firecrystals)
      firecrystals.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @beep.play and @arthurfiredefenceboost += 2
      end
      if @arthurfiredefenceboost>100 then @arthurfiredefenceboost=100 end 
    end

    def collect_firebooks(firebooks)
      firebooks.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @pickupbook.play and @arthurfiremagicboost += 10 and @arthurfiredefenceboost += 2
      end
      if @arthurfiremagicboost>100 then @arthurfiremagicboost=100 end 
      if @arthurfiredefenceboost>100 then @arthurfiredefenceboost=100 end 
    end

    def collect_icecrystals(icecrystals)
      icecrystals.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @beep.play and @arthuricedefenceboost += 2
      end
    end

    def collect_icebooks(icebooks)
      icebooks.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @pickupbook.play and @arthuricemagicboost += 10 and @arthuricedefenceboost += 2
      end
      if @arthuricemagicboost>100 then @arthuricemagicboost=100 end 
      if @arthuricedefenceboost>100 then @arthuricedefenceboost=100 end 
    end
   
    def collect_lightningcrystals(lightningcrystals)
      lightningcrystals.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @beep.play and @arthurlightningdefenceboost += 2
      end
    end

    def collect_lightningbooks(lightningbooks)
      lightningbooks.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @pickupbook.play and @arthurlightningmagicboost += 10 and @arthurlightningdefenceboost += 2
      end
      if @arthurlightningmagicboost>100 then @arthurlightningmagicboost=100 end 
      if @arthurlightningdefenceboost>100 then @arthurlightningdefenceboost=100 end 
    end

    def collect_earthcrystals(earthcrystals)
      earthcrystals.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @beep.play and @arthurearthdefenceboost += 2
      end
    end
  
    def collect_earthbooks(earthbooks)
      earthbooks.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @pickupbook.play and @arthurearthmagicboost += 10 and @arthurearthdefenceboost += 2
      end
      if @arthurearthmagicboost>100 then @arthurearthmagicboost=100 end 
      if @arthurearthdefenceboost>100 then @arthurearthdefenceboost=100 end 
    end
  
    def collect_evilbooks(evilbooks)
      evilbooks.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @pickupbook.play and @arthurevilmagicboost += 10 and @arthurevildefenceboost += 2
      end
      if @arthurevilmagicboost>100 then @arthurevilmagicboost=100 end 
      if @arthurevildefenceboost>100 then @arthurevildefenceboost=100 end 
    end

    def collect_groundareagates(groundareagates)
      groundareagates.each do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and $touchinggrounddungeondoor = 1
      end
    end

    def collect_bluepotions(bluepotions)
      if $numbluepotions<99 then
        bluepotions.reject! do |c|
          (c.x - $x).abs < 20 and (c.y - $y).abs < 25 and @pickuppotion.play and $numbluepotions += 1
        end
      end
      if @arthurmp < @arthurmaxmp then 
        @arthurmprestore += 1
        if @arthurmprestore > 250 then @arthurmprestore = 1 and @arthurmp += 1 end
      end
      if @arthurmp > @arthurmaxmp then @arthurmp=@arthurmaxmp end
    end

    def collect_greenpotions(greenpotions)
      if $numgreenpotions<99 then
        greenpotions.reject! do |c|
          (c.x - $x).abs < 20 and (c.y - $y).abs < 25 and @pickuppotion.play and $numgreenpotions += 1
        end
      end
    end

    def collect_goldpotions(goldpotions)
      if $numgoldpotions<99 then
        goldpotions.reject! do |c|
          (c.x - $x).abs < 20 and (c.y - $y).abs < 25 and @pickuppotion.play and $numgoldpotions += 1
        end
      end
    end

    def collect_redpotions(redpotions)
      if $numredpotions<99 then
        redpotions.reject! do |c|
          (c.x - $x).abs < 20 and (c.y - $y).abs < 25 and @pickuppotion.play and $numredpotions += 1
        end
      end
      if @arthurhp > @arthurmaxhp then @arthurhp=@arthurmaxhp end
  
      if @arthurstatus5 > 0 then 
        @arthurpoisoned += 1
        if @arthurpoisoned > 20 then @arthurhp -= 1 and @arthurpoisoned = 1 end
      end

      if @arthurhp < @arthurmaxhp and  @arthurstatus5 ==0 then 
        @arthurhprestore += 1
        if @arthurhprestore > 1000 then @arthurhprestore = 1 and @arthurhp += 1 end
      end
    end
    
    def collect_swordsandgreyshields(swordsandgreyshields)
      swordsandgreyshields.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 25 and @pickupexpsound.play and @arthurweaponattboost += 5 and @arthurpsysicaldefenceboost += 2 and @arthurexp += 1500
      end
      if @arthurweaponattboost>100 then @arthurweaponattboost=100 end 
      if @arthurpsysicaldefenceboost>100 then @arthurpsysicaldefenceboost=100 end 
    end

    def collect_greyshields(greyshields)
      greyshields.reject! do |c|
        (c.x - $x).abs < 22 and (c.y - $y).abs < 30 and @pickupexpsound.play and @arthurpsysicaldefenceboost += 2 and @arthurexp += 1000
      end
      if @arthurexp>4999 and @arthurexp<11999 then @arthurmaxhp=65 and @arthurmaxmp=30 and @arthurlevel=2  end
      if @arthurexp>11999 and @arthurexp<21999 then @arthurmaxhp=85 and @arthurmaxmp=42 and @arthurlevel=3  end
      if @arthurexp>21999 and @arthurexp<36999 then @arthurmaxhp=110 and @arthurmaxmp=60 and @arthurlevel=4  end
      if @arthurexp>36999 and @arthurexp<58999 then @arthurmaxhp=150 and @arthurmaxmp=90 and @arthurlevel=5  end
      if @arthurexp>58999 and @arthurexp<90999 then @arthurmaxhp=200 and @arthurmaxmp=125 and @arthurlevel=6  end
      if @arthurexp>90999 and @arthurexp<137999 then @arthurmaxhp=265 and @arthurmaxmp=175 and @arthurlevel=7  end
      if @arthurexp>137999 and @arthurexp<204999 then @arthurmaxhp=320 and @arthurmaxmp=215 and @arthurlevel=8  end
      if @arthurexp>204999 and @arthurexp<296999 then @arthurmaxhp=400 and @arthurmaxmp=265 and @arthurlevel=9  end
      if @arthurexp>296999 and @arthurexp<418999 then @arthurmaxhp=512 and @arthurmaxmp=315 and @arthurlevel=10  end
      if @arthurexp>418999 and @arthurexp<575999 then @arthurmaxhp=620 and @arthurmaxmp=365 and @arthurlevel=11  end
      if @arthurexp>575999 and @arthurexp<772999 then @arthurmaxhp=742 and @arthurmaxmp=425 and @arthurlevel=12  end
      if @arthurexp>772999 and @arthurexp<1014999 then @arthurmaxhp=856 and @arthurmaxmp=560 and @arthurlevel=13  end
      if @arthurexp>1014999 and @arthurexp<1306999 then @arthurmaxhp=962 and @arthurmaxmp=650 and @arthurlevel=14  end
      if @arthurexp>1306999 then @arthurmaxhp=1000 and @arthurmaxmp=800 and @arthurlevel=15  end
    end

    def collect_powerup_swords(powerup_swords)
      powerup_swords.reject! do |c|
        (c.x - $x).abs < 25 and (c.y - $y).abs < 35 and @pickupexpsound.play and @arthurweaponattboost += 2 and @arthurexp += 250
      end
    end

    
    # START hit_
    def hit_checkpoint(checkpoints)
      checkpoints.each do |c|
        if (c.x - $x).abs < 40 and (c.y - $y).abs < 40
          @checkpointx = $x
          @checkpointy = $y
          @checkpointarea = $currentarea
        end
      end
      
      if @arthurhp < 1
        $x = @checkpointx
        $y = @checkpointy
        $currentarea = @checkpointarea
        @arthurhp = @arthurmaxhp
        $arthurlives -= 1
        @arthurstatus5 = 0
        # TODO: change music in game.rb, not in this class
        # changemusic
      end
      
      if @arthurmp < 0
        @arthurmp = 0
      end
      
      if $arthurlives < 1
        @game_mode = 1
        @songs[:title_screen].play(looping = true)
      end
    end

    def hit_fires(fires)
      @arthurdamage = 30*@arthurfiredefenceboost/100
          fires.each do |c|
        (c.x - $x).abs < 35 and (c.y - $y).abs < 30 and if @arthurfiredefenceboost<100 then @hitsound.play end and @arthurhp -= 10-@arthurdamage  and if $dir == :left then $x+=15 else $x-=15 end
      end
      if @arthurhp > @arthurmaxhp then @arthurhp=@arthurmaxhp end
    end
  
    def hit_snakes(snakes)
      @arthurdamage = 30*@arthurpsysicaldefenceboost/100
    
      snakes.each do |c|
        #(c.x - $x).abs < 35 and (c.y - $y).abs < 30 and if @arthurpsysicaldefenceboost<100 then @hitsound.play end and @arthurhp -= 10-@arthurdamage and @arthurstatus5=1  and if $dir == :left then $x+=15 else $x-=15 end
        (c.x - $x).abs < 18 and (c.y - $y).abs < 30 and if @arthurpsysicaldefenceboost<100 then @hitsound.play end and @arthurhp -= 10-@arthurdamage and @arthurstatus5=1  and if $dir == :left then $x+=15 else $x-=15 end
      end
    end
 

    # Add all private methods that will only be used inside this class below
    private

    # TODO: extract somewhere, other Creatures might be able to create Dust as well
    def create_dust(x_modifier = 0)
      4.times do
        @smoke.push(DustParticle.new(@window, ($x + x_modifier) + ( @wall*5) + (@wall * rand(10)), $y-10 , rand(50)))                  end
      end      
    end
        
  end # END Arthur
  
  
end