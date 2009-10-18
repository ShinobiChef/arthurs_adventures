class Artventure::Game < Window
  MODES = [:loading, :title, :howto, :playing, :pause, :shopping, :dead, :credits]
  
  attr_reader :resources,
              :player,
              :map,
              :gamexres,
              :gameyres,
              :gamemode,
              :loadedstuff,
              :titlescreeniconpos,
              :pausescreeniconpos,
              :htpgpagenum,
              :lastgamemode,
              :shopscreeniconpos,
              :selectedgroup,
              :rannum

  def initialize
    super(@gamexres = 1280, @gameyres = 800, true)
    self.caption = "Arthur's Adventures v#{VERSION}"

    @rannum = 1
    @game_mode = 1
    @last_game_mode = 1
    @loaded_stuff = false
    @selectedgroup = 1
    @how_to_page = 1
    
    # Scrolling is stored as the position of the top left corner of the screen    
    @screen_x, @screen_y = 0

    # TODO: pack in hash @icon_pos or something
    @title_screen_icon_pos = 1
    @pause_screen_icon_pos = 1
    @shop_screen_icon_pos  = 1
            
    # initialize Resources
    @resources = Resources.new(self)

    load_hud
    load_fonts
    load_backgrounds
    load_images
    load_music
    load_sfx
    load_fonts
    load_sprites
    load_maps
    # initialize map and rest of hud
  
    @arthur = Arthur.new(self, 400, 100)
    
    @players = []
    @players << Player.new("Player 1", @arthur)
    # TODO: maybe a 2nd player could join to move enemies? that would be neat

    @songs[:title_screen].play(looping = true)    
  end


  def update
    # TODO: use symbol instead of numbers
    return if @game_mode != :playing

    $touchingshop = 0   
    
    move_x = 0
    move_x -= 5 and @rannum = (rand 100)+1 if button_down? Button::KbLeft 

    move_x -= 5 and @rannum = (rand 100)+1 if button_down? Button::GpLeft
    move_x += 5 and @rannum = (rand 100)+1 if button_down? Button::KbRight
    move_x += 5 and @rannum = (rand 100)+1 if button_down? Button::GpRight

    #if @rannum == 100 then @menumovesound.play end

    @arthur.update(move_x)
    
    # and @pickupgold.play and $gold += 100

    @sprites.each do |category, array|
      # each creature has something to do each second, maybe wandering around
      array.each{|creature| creature.lifecycle! } if category == :creatures
      # check for collisions (currently only with main character)
      arthur = @players.first.character
      array.each do |sprite|
        if arthur.colliding_with?(sprite)
          arthur.handle_collision!(sprite)
        end
      end
    end
    
    # TODO: refactor collect_methods properly like above
    # @arthur.collect_golds(@map.golds)
    # @arthur.collect_shops(@map.shops)
    # @arthur.collect_helmets(@map.helmets)
    # @arthur.collect_firecrystals(@map.firecrystals)
    # @arthur.collect_firebooks(@map.firebooks)
    # @arthur.collect_icecrystals(@map.icecrystals)
    # @arthur.collect_icebooks(@map.icebooks)
    # @arthur.collect_lightningcrystals(@map.lightningcrystals)
    # @arthur.collect_lightningbooks(@map.lightningbooks)
    # @arthur.collect_earthcrystals(@map.earthcrystals)
    # @arthur.collect_earthbooks(@map.earthbooks)
    # @arthur.collect_evilbooks(@map.evilbooks)
    # @arthur.collect_swordsandgreyshields(@map.swordsandgreyshields)
    # @arthur.collect_groundareagates(@map.groundareagates)
    # @arthur.collect_bluepotions(@map.bluepotions)
    # @arthur.collect_redpotions(@map.redpotions)
    # @arthur.collect_goldpotions(@map.goldpotions)    
    # @arthur.collect_greenpotions(@map.greenpotions)    
    # @arthur.hit_checkpoint(@map.checkpoints)
    # @arthur.hit_fires(@map.fires)
    # @arthur.hit_snakes(@map.snakes)
    # @arthur.collect_greyshields(@map.greyshields)
    # @arthur.collect_powerupswords(@map.powerupswords)


    # Scrolling follows player
    @screen_x = [[@x - @gamexres/2, 0].max, @map.width * 50 - @gamexres].min
    @screen_y = [[@y - @gameyres/2, 0].max, @map.height * 50 - @gameyres].min
  end


  def draw
    
    # Refactor into some methods below
    if @game_mode == :title
      @backgrounds[:title_screen].draw(0, 0, 0)
      
      # @fonts[:title].draw("Press Spacebar or Start Button to Make Selection" , 200, 580,1, 1.0, 1.0, resources.color(:white))
      
      @fonts[:small].draw("v#{VERSION}" , 1230, @gameyres - 20, 1, 1.0, 1.0, resources.color(:white))

      y = case @title_screen_icon_pos
        when 1 then 190
        when 2 then 245
        when 3 then 305
        when 4 then 365
        when 5 then 425
        when 6 when 480
      end
      @images[:menu_icon].(450, y, 0)
    end

    if @game_mode == :credits
      @creditspage.draw(0, 0, 0)
    end 

    if @game_mode == :howto
      @backgrounds[:how_to_guide][@how_to_page-1].draw(0, 0, 0) if @how_to_page > 0
    end 
    
    # TODO: find out what game_mode 0 is good for
    if @game_mode == 0
      $titlescreenmusicogg.play(looping = true)
      @pause_screen_icon_pos = 1
      @game_mode = 1
    end

    # TODO: this is probably the loading screen after the title?
    if @game_mode == 10
      $titlescreenmusicogg.stop
      @arthur.setnewgamevars

      if not @loaded_stuff then
        
        @sprlives = Image.new(self, "data/items/helmet.png", true)   
        @sprlrp = Image.new(self, "data/items/largeredpotion.png", true)   
        @sprlbp = Image.new(self, "data/items/largebluepotion.png", true)
        @sprlgp = Image.new(self, "data/items/largegoldpotion.png", true)
        @sprlgrp = Image.new(self, "data/items/largegreenpotion.png", true)
        @sprlgreyp = Image.new(self, "data/items/largegreypotion.png", true)

        @sprbookfire = Image.new(self, "data/items/bookfire.png", true)   
        @sprbookice = Image.new(self, "data/items/bookice.png", true)   
        @sprbooklightning = Image.new(self, "data/items/booklightning.png", true)
        @sprbookground = Image.new(self, "data/items/bookground.png", true)
        @sprbookevil = Image.new(self, "data/items/bookevil.png", true)
        @sprbookgrey = Image.new(self, "data/items/bookgrey.png", true)

        @sprweapon1 = Image.new(self, "data/items/dagger1-1.png", true)   
        @sprweapon2 = Image.new(self, "data/items/dagger2-1.png", true)   
        @sprweapon3 = Image.new(self, "data/items/dagger3-1.png", true)
        @sprweapon4 = Image.new(self, "data/items/dagger4-1.png", true)
        @sprweapon5 = Image.new(self, "data/items/dagger5-1.png", true)
        @sprweapon6 = Image.new(self, "data/items/dagger6-1.png", true)

        @sprweapon1grey = Image.new(self, "data/items/dagger1-3.png", true)   
        @sprweapon2grey = Image.new(self, "data/items/dagger2-3.png", true)   
        @sprweapon3grey = Image.new(self, "data/items/dagger3-3.png", true)
        @sprweapon4grey = Image.new(self, "data/items/dagger4-3.png", true)
        @sprweapon5grey = Image.new(self, "data/items/dagger5-3.png", true)
        @sprweapon6grey = Image.new(self, "data/items/dagger6-3.png", true)

        @sprarmour1 = Image.new(self, "data/items/armourbronze.png", true)   
        @sprarmour2 = Image.new(self, "data/items/armourred.png", true)   
        @sprarmour3 = Image.new(self, "data/items/armourblue.png", true)
        @sprarmour4 = Image.new(self, "data/items/armourgreen.png", true)
        @sprarmour5 = Image.new(self, "data/items/armourpurple.png", true)
        @sprarmour6 = Image.new(self, "data/items/armourgold.png", true)
        @sprarmour7 = Image.new(self, "data/items/armourgrey.png", true)

        @sprboots1 = Image.new(self, "data/items/bootsnormal.png", true)   
        @sprboots2 = Image.new(self, "data/items/bootsmisc.png", true)   
        @sprboots3 = Image.new(self, "data/items/bootsheavy.png", true)
        @sprboots4 = Image.new(self, "data/items/bootswaterice.png", true)
        @sprboots5 = Image.new(self, "data/items/bootspoison.png", true)
        @sprboots6 = Image.new(self, "data/items/bootsfeather.png", true)
        @sprboots7 = Image.new(self, "data/items/bootsgrey.png", true)

        @sprstatus1 = Image.new(self, "data/items/status1.png", true)   
        @sprstatus2 = Image.new(self, "data/items/status2.png", true)   
        @sprstatus3 = Image.new(self, "data/items/status3.png", true)
        @sprstatus4 = Image.new(self, "data/items/status4.png", true)
        @sprstatus5 = Image.new(self, "data/items/status5.png", true)
        @sprstatus6 = Image.new(self, "data/items/status6.png", true)


        @selectedgroup1box = Image.new(self, "data/items/selectedgroup1box.png", true)
        @selectedgroup2box = Image.new(self, "data/items/selectedgroup2box.png", true)
        @selectedgroup3box = Image.new(self, "data/items/selectedgroup3box.png", true)
        @selectedgroup4box = Image.new(self, "data/items/selectedgroup4box.png", true)
        @selectedgroup5box = Image.new(self, "data/items/selectedgroup5box.png", true)

        @loaded_stuff = 1
      end
      
      load_maps

      @songs[:normal_area].play(looping = true) 
      @game_mode = :playing
    end

    if @game_mode == 11
      @backgrounds[:intro].draw(0, 0, 0)
      @game_mode = 10  
    end

    if @game_mode == :shopping
      @backgrounds[:shop_screen].draw(0, 0, 0)
      @fonts[:small].draw("#{@player.first.creature.inventory.gold}" , 1110, 27, 1, 1.0, 1.0, resources.color[:black])
      y = case @shop_screen_icon_pos
        when 1 then 230
        when 2 then 275
        when 3 then 325
        when 4 then 365
        when 5 then 405
      end
      @images[:menu_icon].draw(400, y, 0)
    end

    if @game_mode == :pause
      @pausescreenimage.draw(0, 0, 0)
      y = case pause_screen_icon_pos
        when 1 then 220
        when 2 then 310
        when 3 then 395
        when 4 then 480
      end
      if @pause_screen_icon_pos == 1 then   @menuicon.draw(400, 220, 0) end
      if @pause_screen_icon_pos == 2 then   @menuicon.draw(400, 310, 0) end
      if @pause_screen_icon_pos == 3 then   @menuicon.draw(400, 395, 0) end
      if @pause_screen_icon_pos == 4 then   @menuicon.draw(400, 480, 0) end
    end
    
    # TODO: what is game_mode 4 good for?
    if @game_mode == 4
      @game_mode = 2
      changemusic  
    end  
  end
  # END draw()


  def button_down(id)
    if @game_mode == 6
      if id == Button::KbSpace or id == Button::GpButton9
        @game_mode = 0
        @menupressbuttonsound.play
      end
    end

    if @game_mode == 5
      if id == Button::KbSpace or id == Button::GpButton9
        @game_mode = @last_game_mode
        @menupressbuttonsound.play
      end

      if id == Button::KbLeft or id == Button::GpLeft
        @how_to_page -= 1
        @menumovesound.play
      end
      
      if id == Button::KbRight or id == Button::GpRight
        @how_to_page += 1
        @menumovesound.play
      end

      @how_to_page = 4 if @how_to_page == 0
      @how_to_page = 1 if @how_to_page == 5
    end
    
    # :shopping
    if @game_mode == 13
      # TODO: create class Shop that takes care of all this stuff
      case id
      when Button::KbJ, Button::GpButton2
        case @shop_screen_icon_pos
        when 1
          if $gold < 50
            @errorsound.play 
          else
            $numredpotions += 1
            $gold -= 50
            @buyitemsound.play
          end
        when 2
          if $gold < 50
            @errorsound.play
          else
            $numbluepotions += 1
            $gold -= 50
            @buyitemsound.play
          end
        end
      end      
      if id == Button::KbJ  or id == Button::GpButton2   and @shop_screen_icon_pos == 3 then   if $gold<50 then @errorsound.play end end
      if id == Button::KbJ  or id == Button::GpButton2   and @shop_screen_icon_pos == 3 then  if $gold>149 then $numgoldpotions += 1 and $gold -= 150 and @buyitemsound.play end end
      if id == Button::KbJ  or id == Button::GpButton2   and @shop_screen_icon_pos == 4 then   if $gold<80 then @errorsound.play end end
      if id == Button::KbJ  or id == Button::GpButton2   and @shop_screen_icon_pos == 4 then  if $gold>79 then $numgreenpotions += 1 and $gold -= 80 and @buyitemsound.play end  end
      if id == Button::KbJ  or id == Button::GpButton2   and @shop_screen_icon_pos == 5 then   if $gold<1000 then @errorsound.play end end
      if id == Button::KbJ  or id == Button::GpButton2  and @shop_screen_icon_pos == 5 then  if $gold>999 then $arthurlives += 1 and $gold -= 1000 and @buyitemsound.play end  end
      if id == Button::KbK  or id == Button::GpButton1  and @menupressbuttonsound.play then  @game_mode = 4  end

      if id == Button::KbUp  or id == Button::GpUp then  @shop_screen_icon_pos -= 1   and @menumovesound.play end
      if id == Button::KbDown  or id == Button::GpDown then  @shop_screen_icon_pos += 1 and @menumovesound.play end

      if @shop_screen_icon_pos == 0 then @shop_screen_icon_pos = 5 end
      if @shop_screen_icon_pos == 6 then @shop_screen_icon_pos = 1 end
    end

    if @game_mode == 3
      if id == Button::KbSpace  or id == Button::GpButton9  and @unpausebuttonsound.play and @pause_screen_icon_pos == 1 then  @game_mode = 4  end
      if id == Button::KbSpace  or id == Button::GpButton9  and @menupressbuttonsound.play and @pause_screen_icon_pos == 2 then  @game_mode = 5 and @last_game_mode = 12  end
      if id == Button::KbSpace  or id == Button::GpButton9  and @menupressbuttonsound.play and @pause_screen_icon_pos == 4 then  @game_mode = 0  end

      if id == Button::KbUp  or id == Button::GpUp then  @pause_screen_icon_pos -= 1   and @menumovesound.play end
      if id == Button::KbDown  or id == Button::GpDown then  @pause_screen_icon_pos += 1 and @menumovesound.play end

      if @pause_screen_icon_pos == 0 then @pause_screen_icon_pos = 4 end
      if @pause_screen_icon_pos == 5 then @pause_screen_icon_pos = 1 end
    end

    if @game_mode == 1
      if id == Button::KbSpace  or id == Button::GpButton9  and @title_screen_icon_pos == 1 then  @menupressbuttonsound.play and @current_area = 1 and @game_mode = 11  end
      if id == Button::KbSpace  or id == Button::GpButton9  and @title_screen_icon_pos == 3 then  @menupressbuttonsound.play and @game_mode = 5 and @last_game_mode = 0 end
      if id == Button::KbSpace  or id == Button::GpButton9  and @title_screen_icon_pos == 5 then  @menupressbuttonsound.play and @game_mode = 6 end
      if id == Button::KbEscape  or id == Button::KbSpace  or id == Button::GpButton9  and @title_screen_icon_pos == 6 then close end
      if id == Button::KbEscape  then close end
      if id == Button::KbUp  or id == Button::GpUp then  @title_screen_icon_pos -= 1   and @menumovesound.play end
      if id == Button::KbDown  or id == Button::GpDown then  @title_screen_icon_pos += 1 and @menumovesound.play end

      if @title_screen_icon_pos == 0 then @title_screen_icon_pos = 6 end
      if @title_screen_icon_pos == 7 then @title_screen_icon_pos = 1 end
    end


    if @game_mode == :playing
      # gamemode 2
      case id
      when Button::KbUp, Button::GpButton2, Button::KbC
        @arthur.try_to_jump
      when Button::KbZ, Button::GpButton3, Button::KbReturn, Button::MsMiddle
        @arthur.useitem
      when Button::KbQ, Button::KbNumpad9, Button::GpButton5, Button::MsWheelDown
        @arthur.changeitemforward if @selectedgroup == 1
      when Button::KbA, Button::KbNumpad3, Button::GpButton4, Button::MsWheelUp
        @arthur.changeitembackward if @selectedgroup == 1
      when Button::KbW, Button::KbNumpad7, Button::GpButton7
        @selectedgroup += 1
      when Button::KbS, Button::KbNumpad1, Button::GpButton6
        @selectedgroup -= 1
      when Button::KbSpace, Button::GpButton9
        pausemusic
        @pausebuttonsound.play 
        @game_mode = 3
      when Button::KbUp, Button::GpUp
        # touching_shop should be method (maybe on Character)  
        if $touchingshop == 1
          pausemusic
          @pausebuttonsound.play 
          @game_mode = 13
        end
      when Button::KbEscape
        @game_mode = 1
        @songs[:title_screen].play(looping = true)
      end

      @selectedgroup = 5 if @selectedgroup == 0
      @selectedgroup = 1 if @selectedgroup == 6
    end

    if @game_mode == 10
    end
    
    # TODO: wtf?
    if @game_mode == 12
      @game_mode = 3 
    end
  end
  
  
  # Music
  def changemusic
    # TODO: make looping default to true or create e.g. play_loop for convenience
    case @arthur.current_area
    when 1..5
      @songs[:normal_area].play(looping = true)
    when 6
      @songs[:ice_area].play(true)
    when 7
      @songs[:fire_area].play(true)
    when 8
      @songs[:normal_area].play(true)
    when 9
      @songs[:evil_area].play(true)
    end
  end

  def pausemusic
    area = case @arthur.current_area
    when 1..5 then :normal_area
    when 6    then :ice_area
    when 7    then :fire_area
    when 8    then :normal_area
    when 9    then :evil_area
    when 10   then :fire_area
    when 11   then :ice_area
    when 12   then :lightning_area
    when 13   then :ground_area
    when 15   then :evil_area
    end
    @songs[area].pause
  end
  
  
  private
  
  def load_sprites
    @sprites = Map::Sprites.new(self)
    # TODO: load all sprites here ?
  end
  
  def load_backgrounds
    @backgrounds = {}
    @backgrounds[:intro]         = resources.background("intro.png")
    @backgrounds[:title_screen]  = resources.background("titlescreenv5.png")
    @backgrounds[:pause_screen]  = resources.background("pausescreen1.png")
    @backgrounds[:shop_screen]   = resources.background("shopscreen1.png")
    @backgrounds[:credits]       = resources.background("credits.png")
    @backgrounds[:how_to_guide] = []
    @backgrounds[:how_to_guide] << resources.background("htpgp1.png")
    @backgrounds[:how_to_guide] << resources.background("htpgp2.png")
    @backgrounds[:how_to_guide] << resources.background("htpgp3.png")
    @backgrounds[:how_to_guide] << resources.background("htpgp4.png")    
  end
  
  def load_images
    @images = {}
    @images[:menu_icon] = resources.image("items/dagger4-2.png", true)
  end
  
  def load_hud
    @hud = {}
    @hud[:stats_box]   = Hud::StatsBox.new(self)
    @hud[:health_bar]  = Hud::AttributeBar.new(self, 10, 100, resources.color(:green), @players.first, :health)
    @hud[:mana_bar]    = Hud::AttributeBar.new(self, 10, 110, resources.color(:blue), @players.first, :mana)
    @hud[:fps_counter] = Hud::FPSCounter.new(self, 1200, 100)
  end

  def load_music
    @songs = {}
    @songs[:title_screen]   = resources.song("ArthurTheme.ogg", volume = 0.15)
    @songs[:normal_area]    = resources.song("NormalRealm.ogg", 0.15)
    @songs[:fire_area]      = resources.song("FireRealm.mid", 0.15)
    @songs[:ice_area]       = resources.song("IceRealm.ogg", 0.20)
    @songs[:lightning_area] = resources.song("NormalRealm.ogg", 0.15)
    @songs[:ground_area]    = resources.song("PoisonRealm.ogg", 0.60)
    @songs[:evil_area]      = resources.song("EvilRealm.mid", 0.60)
  end
  
  def load_sfx
    @sfx = {}
    @sfx[:menu_move]         = resources.sfx("menumovesound.wav")
    @sfx[:menu_press_button] = resources.sfx("bpress.wav")
    @sfx[:pause_button]      = resources.sfx("pausesound.wav")
    @sfx[:unpause_button]    = resources.sfx("unpausesound.wav")
    @sfx[:error]             = resources.sfx("errorsound.wav")
    @sfx[:buy_item]          = resources.sfx("buyitem1.wav")
  end
  
  def load_fonts
    @fonts = {]
    @fonts[:default] = resources.font(:default)
    @fonts[:small]   = resources.font(:small)
    @fonts[:title]   = resources.font(:title)
    @fonts[:credits] = resources.font(:credits)
  end
  
  def load_maps
    @tiles = {}
    @tiles[:normal_area]    = resources.tiles("tiles/normalrealmtileset.png", 60, 60)
    @tiles[:fire_area]      = resources.tiles("tiles/firerealmtileset.png", 60, 60)
    @tiles[:normal_area]    = resources.tiles("tiles/icerealmtileset3.png", 60, 60)
    @tiles[:lightning_area] = resources.tiles("tiles/lightningrealmtileset.png", 60, 60)
    @tiles[:ground_area]    = resources.tiles("tiles/groundrealmtileset.png", 60, 60)
    @tiles[:desert_area]    = resources.tiles("tiles/groundrealmtileset.png", 60, 60)
    @tiles[:evil_area]      = resources.tiles("tiles/evilrealmtileset.png", 60, 60)

    # @current_areabkimage = Image.new(self, "data/backgrounds/blank.png", true)
    
    @maps = {}
    @maps[:template]       = Map.new(self, "template", "blank.png")
    @maps[:area1]          = Map.new(self, "area1", "area1bk.png")
    @maps[:area2]          = Map.new(self, "area2", "area2bk.png")
    @maps[:area3]          = Map.new(self, "area3", "area3bk.png")
    @maps[:area4]          = Map.new(self, "area4", "area4bk.png")
    @maps[:area5]          = Map.new(self, "area5", "area5bk.png")
    @maps[:area6]          = Map.new(self, "area6", "area6bk.png")
    @maps[:area7]          = Map.new(self, "area7", "area7bk.png")
    @maps[:area8]          = Map.new(self, "area8", "area8bk.png")
    @maps[:area9]          = Map.new(self, "area9", "area9bk.png")
    @maps[:fire_area]      = Map.new(self, "firedungeon", "firedungeonbk.png")
    @maps[:ice_area]       = Map.new(self, "icedungeon", "icedungeonbk.png")
    @maps[:lightning_area] = Map.new(self, "lightningdungeon", "lightningdungeonbk.png")
    @maps[:ground_area]    = Map.new(self, "grounddungeon", "grounddungeonbk.png")
    @maps[:evil_area]      = Map.new(self, "evildungeon", "area9bk.png")
    
    @map = @maps[:template]
  end
  
  
  # This is the normal game workflow when you are playing and moving the character
  def draw_active_game
    if @x > 12470 and [1,2,4,5,7,8].include?(@current_area)
        #$teleportgatesound.play 
      @x = 25 
      @dir = :right
      @current_area += 1 
      changemusic
    end

    if @x > 10 and @x < 25 and [2,3,5,6,8,9].include?(@current_area)
      #$teleportgatesound.play 
      @x = 12450 
      @dir = :left
      @current_area -= 1 
      changemusic
    end

    if @y > 9975 and [1,2,3,4,5,6].include?(@current_area)
      #$teleportgatesound.play 
      @y = 56 
      @current_area += 3 
      changemusic    
    end


    if @y > 45 and @y < 55 and [4,5,6,7,8,9].include?(@current_area)
      #$teleportgatesound.play 
      @y = 9975 
      @current_area -= 3 
      changemusic    
    end


    if @current_area == 15 and @x > 12475 and @x < 12495 and @y < 9950 and @y > 9800
      #$teleportgatesound.play 
      @x = 18760 
      @y = 18699 
      @dir = :right
      @current_area = 1 
      $normalareamusicogg.play(looping = true)       
    end


    # TODO: extract into a method or hash and use symbols instead of numbers
    @current_areabkimage, @map = \
    case @current_area
    when 1..9
      @area1bk, $area1map
    when 10
      @fireareabk, $fireareamap
    when 11
      @iceareabk, $iceareamap
    when 12
      @lightningareabk, $lightningareamap
    when 13
      @groundareabk, $groundareamap
    when 15
      @evilareabk, $evilareamap
    end

    # DRAW
    @current_areabkimage.draw(-@screen_x/8, -@screen_y/8, 0)

    @map.draw @screen_x, @screen_y , @gamexres , @gameyres
    @arthur.draw @screen_x, @screen_y 
    @sprlives.draw(1055, -5, 0)
    @fonts[:default].draw("#{$arthurlives} Lvl: #{@arthur.arthurlevel} " , 1090, 10,1, 1.0, 1.0, 0xffffffff)
    @fonts[:default].draw("Exp: #{@arthur.arthurexp}" , 1070, 30,1, 1.0, 1.0, 0xffffffff)
    @fonts[:default].draw("Gold: #{$gold}" , 1070, 50,1, 1.0, 1.0, 0xffffffff)

    #@fonts[:default].draw("HP: #{@arthur.arthurhp}/#{@arthur.arthurmaxhp} MP: #{@arthur.arthurmp}/#{@arthur.arthurmaxmp} Exp: #{@arthur.arthurexp} WAB: #{@arthur.arthurweaponattboost}%  PDB: #{@arthur.arthurpsysicaldefenceboost}% Level: #{@arthur.arthurlevel} Rubys: #{@arthur.gold} Lives: #{@arthur.arthurlives}", 10, 196,1, 1.0, 1.0, 0xffffffff)
    @fonts[:small]("#{@arthur.arthurfiremagicboost}%", 202, 35,1, 1.0, 1.0, 0xffffffff)
    @fonts[:small]("#{@arthur.arthuricemagicboost}%", 237, 35,1, 1.0, 1.0, 0xffffffff)
    @fonts[:small]("#{@arthur.arthurlightningmagicboost}%", 272, 35,1, 1.0, 1.0, 0xffffffff)
    @fonts[:small]("#{@arthur.arthurearthmagicboost}%", 307, 35,1, 1.0, 1.0, 0xffffffff)
    @fonts[:small]("#{@arthur.arthurevilmagicboost}%", 202, 80,1, 1.0, 1.0, 0xffffffff)
    #@fonts[:default].draw("AD:#{@arthur.arthurdamage} SX:#{@screen_x} SY:#{@screen_y}" , 700, 115,1, 1.0, 1.0, 0xffffffff)
    @fonts[:default].draw("X:#{@x} Y:#{@y}" , 700, 100,1, 1.0, 1.0, 0xffffffff)

    @fonts[:small]("Current area:#{@current_area} selectedgroup:#{@selectedgroup} " , 1000, 100,1, 1.0, 1.0, 0xffffffff)
    #@fonts[:small]("rannum:#{@rannum} " , 1000, 130,1, 1.0, 1.0, 0xffffffff) 

    @fonts[:default].draw("#{$numredpotions} ", 45, 11,1, 1.0, 1.0, 0xffffffff)
    @fonts[:default].draw("#{$numbluepotions} ", 89, 11,1, 1.0, 1.0, 0xffffffff)
    @fonts[:default].draw("#{$numgoldpotions} ", 134, 11,1, 1.0, 1.0, 0xffffffff)
    @fonts[:default].draw("#{$numgreenpotions} ", 178, 11,1, 1.0, 1.0, 0xffffffff)

    x = case @selectedgroup
    when 1
      10
    when 2
      200
    when 3
      342
    when 4
      472
    when 5
      596
    end
    @selectedgroup1box.draw(x, 0, 0)

    if $numredpotions>0 then @sprlrp.draw(8, -15, 0) else @sprlgreyp.draw(8, -15, 0) end        
    if $numbluepotions>0 then @sprlbp.draw(52, -15, 0) else @sprlgreyp.draw(52, -15, 0) end        
    if $numgoldpotions>0 then @sprlgp.draw(96, -15, 0) else @sprlgreyp.draw(96, -15, 0) end        
    if $numgreenpotions>0 then @sprlgrp.draw(140, -15, 0) else @sprlgreyp.draw(140, -15, 0) end        

    if @arthur.arthurfiremagicboost>0 then @sprbookfire.draw(195, -5, 0) else @sprbookgrey.draw(195, -5, 0) end        
    if @arthur.arthuricemagicboost>0 then @sprbookice.draw(230, -5, 0) else @sprbookgrey.draw(230, -5, 0) end        
    if @arthur.arthurlightningmagicboost>0 then @sprbooklightning.draw(265, -5, 0) else @sprbookgrey.draw(265, -5, 0) end        
    if @arthur.arthurearthmagicboost>0 then @sprbookground.draw(300, -5, 0) else @sprbookgrey.draw(300, -5, 0) end        
    if @arthur.arthurevilmagicboost>0 then @sprbookevil.draw(195, 40, 0) else @sprbookgrey.draw(195, 40, 0) end        


    if @arthur.arthurweapon1>0 then @sprweapon1.draw(345, -5, 0) else @sprweapon1grey.draw(345, -5, 0) end        
    if @arthur.arthurweapon2>0 then @sprweapon2.draw(380, -5, 0) else @sprweapon2grey.draw(380, -5, 0) end        
    if @arthur.arthurweapon3>0 then @sprweapon3.draw(415, -5, 0) else @sprweapon3grey.draw(415, -5, 0) end        
    if @arthur.arthurweapon4>0 then @sprweapon4.draw(345, 40, 0) else @sprweapon4grey.draw(345, 40, 0) end        
    if @arthur.arthurweapon5>0 then @sprweapon5.draw(380, 40, 0) else @sprweapon5grey.draw(380, 40, 0) end        
    if @arthur.arthurweapon6>0 then @sprweapon6.draw(415, 40, 0) else @sprweapon6grey.draw(415, 40, 0) end        

    if @arthur.arthurarmour1>0 then @sprarmour1.draw(485, 5, 0) else @sprarmour7.draw(485, 5, 0) end        
    if @arthur.arthurarmour2>0 then @sprarmour2.draw(520, 5, 0) else @sprarmour7.draw(520, 5, 0) end        
    if @arthur.arthurarmour3>0 then @sprarmour3.draw(555, 5, 0) else @sprarmour7.draw(555, 5, 0) end        
    if @arthur.arthurarmour4>0 then @sprarmour4.draw(485, 50, 0) else @sprarmour7.draw(485, 50, 0) end        
    if @arthur.arthurarmour5>0 then @sprarmour5.draw(520, 50, 0) else @sprarmour7.draw(520, 50, 0) end        
    if @arthur.arthurarmour6>0 then @sprarmour6.draw(555, 50, 0) else @sprarmour7.draw(555, 50, 0) end        


    if @arthur.arthurboots1>0 then @sprboots1.draw(600, 5, 0) else @sprboots7.draw(600, 5, 0) end        
    if @arthur.arthurboots2>0 then @sprboots2.draw(635, 5, 0) else @sprboots7.draw(635, 5, 0) end        
    if @arthur.arthurboots3>0 then @sprboots3.draw(670, 5, 0) else @sprboots7.draw(670, 5, 0) end        
    if @arthur.arthurboots4>0 then @sprboots4.draw(600, 50, 0) else @sprboots7.draw(600, 50, 0) end        
    if @arthur.arthurboots5>0 then @sprboots5.draw(635, 50, 0) else @sprboots7.draw(635, 50, 0) end        
    if @arthur.arthurboots6>0 then @sprboots6.draw(670, 50, 0) else @sprboots7.draw(670, 50, 0) end        

    if @arthur.arthurstatus1>0 then @sprstatus1.draw(30, 65, 0) end        
    if @arthur.arthurstatus2>0 then @sprstatus2.draw(55, 65, 0) end        
    if @arthur.arthurstatus3>0 then @sprstatus3.draw(80, 65, 0) end        
    if @arthur.arthurstatus4>0 then @sprstatus4.draw(105, 65, 0) end        
    if @arthur.arthurstatus5>0 then @sprstatus5.draw(130, 65, 0) end        
    if @arthur.arthurstatus6>0 then @sprstatus6.draw(155, 65, 0) end        

    draw_hud
  end

  def draw_hud
    @hud[:stats_box].draw
    @hud[:health_bar].draw
    @hud[:mana_bar].draw
    @hud[:fps_counter].draw
  end
end # end class Game