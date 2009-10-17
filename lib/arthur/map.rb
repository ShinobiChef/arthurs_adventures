# Map class holds and draws tiles and golds.
class Artventure::Map
  SQUARE_SIZE = 50
  attr_reader :width,
              :height,
 
  def initialize(game, filename)
    @game, @filename = game, filename
    # Load 60x60 tiles, 5px overlap in all four directions.    

    # TODO: create Resources#font(name) method with defaults
    @font2 = Gosu::Font.new(window, Gosu::default_font_name, 20)
    @map = nil
  end
 
  #Draw map content: (tiles, items)
  def draw(screen_x, screen_y, width, height)
        
    #Improved drawing function:
    @height.times do |y|
      # Skip if not on (vertical) screen
      yz = y * SQUARE_SIZE - 5
      next if yz > screen_y + height or yz + SQUARE_SIZE < screen_y
      
      @width.times do |x|
        # Skip if not on (vertical) screen
        xz = x * SQUARE_SIZE-  5
        next if xz > screen_x + width or xz + SQUARE_SIZE < screen_x
      
        tile = @tiles[x][y]
      
        if tile
          # Draw the tile with an offset (tile images have some overlap)
          # Scrolling is implemented here just as in the game objects.
          case @currentarea
          when 1, 2, 3, 4, 5
            $normalareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
          when 6
            $iceareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
          when 7
            $fireareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1) 
          when 8
            $desertareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
          when 9
            $evilareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
          when 10
            $fireareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
          when 11
            $iceareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
          when 12
            $lightningareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
          when 13
            $groundareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
          # TODO: what about 14 ?
          when 15
            $evilareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
          end
        end
      end
    end
    
    # DRAW all sprites
    @sprites.each do |category, members|
      members.each do |sprite|
        sprite.draw(screen_x, screen_y)
      end
    end    
  end
 
  
  # returns map as an 2d array
  def load
    lines = File.readlines(filename).map { |line| line.chop }

    @width = lines[0].size
    @height = lines.size
    
    # TODO: check if x, y are absolute or relative values (probably relative, so maybe e.g. Fire.new(x,y) needs to use relative values while drawing)      
    @map = Array.new(@width) do |x|
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
          Sprites[:fires] << Fire.new(@window, x, y)
        when 'J'
          Sprites[:snakes] << Snake.new(@window, x, y)
        when 'c'
          Sprites[:checkpoints] << CheckpointSkull.new(@windows, x, y)
        when 'S'
          Sprites[:powerupswords] << PowerupSword.new(@window, x, y)
        when 'H'
          Sprites[:helmets] << Collectiblehelmet.new(@window, x, y)
        when 'v'
          Sprites[:firecrystals] << Collectiblefirecrystal.new(@window, x, u)
        when 'a'
          Sprites[:firebooks] << Collectiblefirebook.new(@window, x, y)
        when 'y'
          Sprites[:icecrystals] << Collectibleicecrystal.new(@window, x, y)
        when 'i'
          Sprites[:icebooks] << Collectibleicebook.new(@window, x, y)
        when 'l'
          Sprites[:lightningcrystals] << Collectiblelightningcrystal.new(@window, x, y)
        when 'z'
          Sprites[:lightningbooks] << Collectiblelightningbook.new(@window, x, y)
        when 'V'
          Sprites[:earthcrystals] << Collectibleearthcrystal.new(@window, x, y)
        when 'b'
          Sprites[:earthbooks] << Collectibleearthbook.new(@window, x, y)
        when 'p'
          Sprites[:signs] << Sign.new(@window, x, y)
        when 'e'
          Sprites[:evilbooks] << Collectibleevilbook.new(@window, x, y)
        when 'C'
          Sprites[:swordsandgreyshields] << Collectibleswordsandgreyshield.new(@window, x, y)
        when 'T'
          Sprites[:tree1s] << Bktree1.new(@window, x, y)
        when 'F'
          Sprites[:tree2s] << Collectibletree2.new(@window, x, y)
        when 'I'
          Sprites[:tree3s] << Collectibletree3.new(@window, x, y)
        when 'L'
          Sprites[:tree4s] << Collectibletree4.new(@window, x, y)
        when 'G'
          Sprites[:groundareagates] << Collectiblegroundareagate.new(@window, x, y)
        when 'E'
          Sprites[:house1s] << Collectiblehouse1.new(@window, x, y)
        when 's'
          Sprites[:greyshields] << Collectiblegreyshield.new(@window, x, y)
        when 'm'
          Sprites[:bluepotions] << Collectiblebluepotion.new(@window, x, y)
        when 'h'
          Sprites[:redpotions] << Collectibleredpotion.new(@window, x, y)
        when 'Y'
          Sprites[:goldpotions] << CollectibleGoldPotion.new(@window, x, y)
        when 'g'
          Sprites[:greenpotions] << Collectiblegreenpotion.new(@window, x, y)
        when 'x'
          Sprites[:golds] << Gold.new(@window, x, y)
        when 'R'
          Sprites[:shops] << Shop.new(@window, x, y)
        else
          # nada ?
        end
      end
    end
  end
  
  def loaded?
    not map.nil?
  end
  
  
  private
    
  # Solid at a given pixel position?
  def solid?(x, y)
    y < 0 || @tiles[x / SQUARE_SIZE][y / SQUARE_SIZE]
  end
  
end