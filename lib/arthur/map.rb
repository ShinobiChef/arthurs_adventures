# Map class holds and draws tiles and golds.
class Artventure::Map
  
  module Tiles
    # TODO: maybe use symbols instead of constants
    ALL = {
      '"' => Grass,
      '#' => Earth,
      '`' => Bstone,
      '~' => Bstoneg
      '1' => Ystone,
      '!' => Ystoneg,
      '@' => Rstoneg,
      '2' => Rstone,
      '4' => Earthw1,
      '$' => Ystonew1,
      '5' => Rstonew1,
      '%' => Earthw2,
      '6' => Earthw3,
      '^' => Earthw4,
      '7' => Ystonew2,
      '&' => Ystonew3,
      '8' => Ystonew4,
      '*' => Rstonew2,
      '9' => Rstonew3,
      '(' => Rstonew4,
      '0' => Istonew2,
      ')' => Istonew3,
      'q' => Istonew4,
      'Q' => Istonew1
    }
    
    def self.from_string(string)
      ALL[string.to_s]
    end
  end
  
  
  class Sprites
    # Note: relative position, not absolute pixel point
    ALL = {
      'f' => Fire, # :fires
      'J' => Snake, # :snakes,
      'c' => CheckpointSkull, # :checkpoints
      'S' => PowerupSword, # :powerupswords
      'H' => Helmet, # :helmets
      'v' => FireCrystal, # :firecrystals
      'a' => FireBook, # :firebooks
      'y' => IceCrystal, # :icecrystals
      'i' => IceBook, # :icebooks
      'l' => LightningCrystal, # :lightningcrystals
      'z' => LightningBook, # :lightningbooks
      'V' => EarthCrystal, # :earthcrystals
      'b' => EarthBook, # :earthbooks
      'p' => Sign, # :signs
      'e' => EvilBook, # :evilbooks
      'C' => SwordsAndGreyShield, # :swordsandgreyshields
      'T' => Tree1, # :tree1s
      'F' => Tree2, # :tree2s
      'I' => Tree3, # :tree3s
      'L' => Tree4, # :tree4s
      'G' => GroundAreaGate, # :groundareagates
      'E' => House1, # :house1s
      's' => GreyShield, # :greyshields
      'm' => BluePotion, # :bluepotions
      'h' => Redpotion, # :redpotions
      'Y' => GoldPotion, # :goldpotions
      'g' => GreenPotion, # :greenpotions
      'x' => Gold, # :golds
      'R' => Shop # :shops
    }
    
    attr_reader :game, :sprites
    
    def initialize(game)
      @game = game
      @sprites = Hash.new([])
    end
    
    def from_string(string, x, y)
      sprite_class = ALL[string.to_s]
      sprite = sprite_class.new(game, x, y)
      sprites[sprite_class.name.downcase + 's'] << sprite
      sprite
    end
  end
  
  
  
  SQUARE_SIZE = 50

  attr_reader :width,
              :height,
 
  def initialize(game, map_name)
    @game = game
    @filename = "#{DATA_DIR}/maps/#{map_name}.map"
    # Load 60x60 tiles, 5px overlap in all four directions.    

    # @map not loaded yet to save loading time
    @map = nil
  end
 
 
  # Draw map content: (tiles, items)
  def draw(screen_x, screen_y, width, height)  
    # Improved drawing function:
    @height.times do |y|
      # Skip if not on (vertical) screen
      yz = y * SQUARE_SIZE - 5
      next if yz > screen_y + height or yz + SQUARE_SIZE < screen_y
      
      @width.times do |x|
        # Skip if not on (horizontal) screen
        xz = x * SQUARE_SIZE-  5
        next if xz > screen_x + width or xz + SQUARE_SIZE < screen_x
      
        # TODO: get the following 3 lines right and remove the case statement for a method or hash:
        # tile = @tiles[x][y]
        # game.tilesets.
        # $normalareatileset[tile].draw(xz - screen_x, yz - screen_y, 0, 1, 1)
        
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
    lines = File.readlines(@filename).map { |line| line.chop.strip }

    @width = lines[0].size
    @height = lines.size
    
    # TODO: check if x, y are absolute or relative values (probably relative, so maybe e.g. Fire.new(x,y) needs to use relative values while drawing)      
    @map = Array.new(@width) do |x|
      Array.new(@height) do |y|
        object_as_string = lines[y][x, 1]
        Tiles.from_string(object_as_string) || game.sprites.from_string(object_as_string, x, y)
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