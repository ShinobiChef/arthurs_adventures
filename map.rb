# Map class holds and draws tiles and golds.

class Map
  attr_reader :width, :height, :golds, :greyshields, :powerupswords,:fires,:snakes,:bluepotions,:redpotions,:goldpotions,:greenpotions,
  :checkpoints,:helmets,:firecrystals,:icecrystals,:lightningcrystals,:earthcrystals,:signs,
 :tree1s,:tree2s,:tree3s,:tree4s,:groundareagates,:house1s,
 :firebooks,:icebooks,:lightningbooks,:earthbooks,:evilbooks,:swordsandgreyshields,:shops
 
  def initialize(window, filename)
    # Load 60x60 tiles, 5px overlap in all four directions.
    
      @font2 = Gosu::Font.new(window, Gosu::default_font_name, 20)
    
    
      @spritembox = Image.new(window, "data/items/statsbox.png", true)
      @sprstatsbanner = Image.new(window, "data/backgrounds/statsbanner.png", true)
      #@sprselecteditembox = Image.new(window, "data/selecteditembox.png", true)
 

      gold_img = Image.new(window, "data/items/gold2.png", false)
      @golds = []
    
      shop_img = Image.new(window, "data/items/wizardred.png", false)
      @shops = []
  

      helmet_img = Image.new(window, "data/items/helmet.png", false)
      @helmets = []
    
      firecrystal_img = Image.new(window, "data/items/crystalfire.png", false)
      @firecrystals = []
    
      firebook_img = Image.new(window, "data/items/bookfire.png", false)
      @firebooks = []
    
      icecrystal_img = Image.new(window, "data/items/crystalice.png", false)
      @icecrystals = []
    
      icebook_img = Image.new(window, "data/items/bookice.png", false)
      @icebooks = []
    
      lightningcrystal_img = Image.new(window, "data/items/crystallightning.png", false)
      @lightningcrystals = []
    
      lightningbook_img = Image.new(window, "data/items/booklightning.png", false)
      @lightningbooks = []
    
      earthcrystal_img = Image.new(window, "data/items/crystalearth.png", false)
      @earthcrystals = []
    
      earthbook_img = Image.new(window, "data/items/bookground.png", false)
      @earthbooks = []
    
   
      sign_img = Image.new(window, "data/items/sign2-small.png", false)
      @signs = []
    
      evilbook_img = Image.new(window, "data/items/bookevil.png", false)
      @evilbooks = []
    
      swordsandgreyshield_img = Image.new(window, "data/items/2swordsandgreyshield.png", false)
      @swordsandgreyshields = []
    
      tree1_img = Image.new(window, "data/items/tree1.png", false)
      @tree1s = []
    
      tree2_img = Image.new(window, "data/items/tree2.png", false)
      @tree2s = []
    
      tree3_img = Image.new(window, "data/items/tree3.png", false)
      @tree3s = []
    
      tree4_img = Image.new(window, "data/items/tree4.png", false)
      @tree4s = []
    
      groundareagate_img = Image.new(window, "data/items/caveofground.png", false)
      @groundareagates = []
    
   
      house1_img = Image.new(window, "data/items/house1.png", false)
      @house1s = []
    
      greenpotion_img = Image.new(window, "data/items/largegreenpotion.png", false)
      @greenpotions = []
    
      bluepotion_img = Image.new(window, "data/items/largebluepotion.png", false)
      @bluepotions = []
    
      redpotion_img = Image.new(window, "data/items/largeredpotion.png", false)
      @redpotions = []
    
      goldpotion_img = Image.new(window, "data/items/largegoldpotion.png", false)
      @goldpotions = []
    
      fire_img = Image.new(window, "data/enemys/fire.png", false)
      @fires = []
 
     snake_img = Image.new(window, "data/enemys/snake.png", false)
      @snakes = []
 
 
      checkpoint_img = Image.new(window, "data/items/skullcheckpoint.png", false)
      @checkpoints = []
 
      greyshield_img = Image.new(window, "data/items/greyshield.png", false)
      @greyshields = []

      powerupsword_img = Image.new(window, "data/items/powerupsword2.png", false)
      @powerupswords = []
 
      lines = File.readlines(filename).map { |line| line.chop }
      @height = lines.size
      @width = lines[0].size
      @tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        case lines[y][x, 1]
        when '"'
          Tiles::Grass
        when '#'
          Tiles::Earth
        when '`'
          Tiles::Bstone
         when '~'
          Tiles::Bstoneg
          when '1'
          Tiles::Ystone
          when '!'
          Tiles::Ystoneg
          when '@'
          Tiles::Rstoneg
          when '2'
          Tiles::Rstone
          when '4'
          Tiles::Earthw1
          when '$'
          Tiles::Ystonew1
          when '5'
          Tiles::Rstonew1
          when '%'
          Tiles::Earthw2
          when '6'
          Tiles::Earthw3
          when '^'
          Tiles::Earthw4
          when '7'
          Tiles::Ystonew2
          when '&'
          Tiles::Ystonew3
          when '8'
          Tiles::Ystonew4
          when '*'
          Tiles::Rstonew2
          when '9'
          Tiles::Rstonew3
          when '('
          Tiles::Rstonew4
          when '0'
          Tiles::Istonew2
          when ')'
          Tiles::Istonew3
          when 'q'
          Tiles::Istonew4
          when 'Q'
          Tiles::Istonew1
          when 'f'
          @fires.push(Hitablefire.new(fire_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'J'
          @snakes.push(Hitablesnake.new(snake_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'c'
          @checkpoints.push(Checkpointskull.new(checkpoint_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'S'
          @powerupswords.push(Collectiblepowerupsword.new(powerupsword_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'H'
          @helmets.push(Collectiblehelmet.new(helmet_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'v'
          @firecrystals.push(Collectiblefirecrystal.new(firecrystal_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'a'
          @firebooks.push(Collectiblefirebook.new(firebook_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'y'
          @icecrystals.push(Collectibleicecrystal.new(icecrystal_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'i'
          @icebooks.push(Collectibleicebook.new(icebook_img, x * 50 + 25, y * 50 + 25))
          nil
        when 'l'
          @lightningcrystals.push(Collectiblelightningcrystal.new(lightningcrystal_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'z'
          @lightningbooks.push(Collectiblelightningbook.new(lightningbook_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'V'
          @earthcrystals.push(Collectibleearthcrystal.new(earthcrystal_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'b'
          @earthbooks.push(Collectibleearthbook.new(earthbook_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'p'
          @signs.push(Sign.new(sign_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'e'
          @evilbooks.push(Collectibleevilbook.new(evilbook_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'C'
          @swordsandgreyshields.push(Collectibleswordsandgreyshield.new(swordsandgreyshield_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'T'
          @tree1s.push(Bktree1.new(tree1_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'F'
          @tree2s.push(Collectibletree2.new(tree2_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'I'
          @tree3s.push(Collectibletree3.new(tree3_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'L'
          @tree4s.push(Collectibletree4.new(tree4_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'G'
          @groundareagates.push(Collectiblegroundareagate.new(groundareagate_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'E'
          @house1s.push(Collectiblehouse1.new(house1_img, x * 50 + 25, y * 50 + 25))
          nil
          when 's'
          @greyshields.push(Collectiblegreyshield.new(greyshield_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'm'
          @bluepotions.push(Collectiblebluepotion.new(bluepotion_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'h'
          @redpotions.push(Collectibleredpotion.new(redpotion_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'Y'
          @goldpotions.push(Collectiblegoldpotion.new(goldpotion_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'g'
          @greenpotions.push(Collectiblegreenpotion.new(greenpotion_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'x'
          @golds.push(Collectiblegold.new(gold_img, x * 50 + 25, y * 50 + 25))
          nil
          when 'R'
          @shops.push(Collectibleshop.new(shop_img, x * 50 + 25, y * 50 + 25))
          nil
          else
          nil
        end
      end
    end
    end
 
  #Draw map content: (tiles, items)
  def draw(screen_x, screen_y, width, height)
        
        #Improved drawing function:
        @height.times do |y|
        #Skip if not on (vertical) screen
        yz = y*50-5
        next if yz > screen_y + height or yz + 50 < screen_y
        @width.times do |x|
        #Skip if not on (vertical) screen
        xz = x*50-5
        next if xz > screen_x + width or xz + 50 < screen_x
        tile = @tiles[x][y]
        if tile
          # Draw the tile with an offset (tile images have some overlap)
          # Scrolling is implemented here just as in the game objects.
          
        if $currentarea == 1 then $normalareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 2 then $normalareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 3 then $normalareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 4 then $groundareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 5 then $normalareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 6 then $iceareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 7 then $fireareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 8 then $desertareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 9 then $evilareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 10 then $fireareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 11 then $iceareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 12 then $lightningareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 13 then $groundareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end
        if $currentarea == 15 then $evilareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) end         
       
        end
      end
    end

      @golds.each { |c| c.draw(screen_x, screen_y) }
      @shops.each { |c| c.draw(screen_x, screen_y) }
      @helmets.each { |c| c.draw(screen_x, screen_y) }
      @firecrystals.each { |c| c.draw(screen_x, screen_y) }
      @firebooks.each { |c| c.draw(screen_x, screen_y) }
      @icecrystals.each { |c| c.draw(screen_x, screen_y) }
      @icebooks.each { |c| c.draw(screen_x, screen_y) }
      @lightningcrystals.each { |c| c.draw(screen_x, screen_y) }
      @lightningbooks.each { |c| c.draw(screen_x, screen_y) }
      @earthcrystals.each { |c| c.draw(screen_x, screen_y) }
      @earthbooks.each { |c| c.draw(screen_x, screen_y) }
      @signs.each { |c| c.draw(screen_x, screen_y) }
      @evilbooks.each { |c| c.draw(screen_x, screen_y) }
      @swordsandgreyshields.each { |c| c.draw(screen_x, screen_y) }
      @tree1s.each { |c| c.draw(screen_x, screen_y) }
      @tree2s.each { |c| c.draw(screen_x, screen_y) }
      @tree3s.each { |c| c.draw(screen_x, screen_y) }
      @tree4s.each { |c| c.draw(screen_x, screen_y) }
      @groundareagates.each { |c| c.draw(screen_x, screen_y) }
      @house1s.each { |c| c.draw(screen_x, screen_y) }
      @bluepotions.each { |c| c.draw(screen_x, screen_y) }
      @redpotions.each { |c| c.draw(screen_x, screen_y) }
      @goldpotions.each { |c| c.draw(screen_x, screen_y) }
      @greenpotions.each { |c| c.draw(screen_x, screen_y) }
      @fires.each { |c| c.draw(screen_x, screen_y) }
      @snakes.each { |c| c.draw(screen_x, screen_y) }
      @checkpoints.each { |c| c.draw(screen_x, screen_y) }
      @greyshields.each { |c| c.draw(screen_x, screen_y) }
      @powerupswords.each { |c| c.draw(screen_x, screen_y) }

      @spritembox.draw(0, 0, 0,1,1,0x80ffffff)
      #@sprstatsbanner.draw(0,95, 0,1,1,0x80ffffff)
  end
 
  # Solid at a given pixel position?
  def solid?(x, y)
    y < 0 || @tiles[x / 50][y / 50]
    end
end

