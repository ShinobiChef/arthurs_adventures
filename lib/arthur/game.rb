class Artventure::Game < Window
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
    # - @gamexres, @gameyres = 1280, 800
    super(@gamexres = 1280, @gameyres = 800, true)

    @rannum = 1
    @last_game_mode = 1
    @game_mode = 1
    @loaded_stuff = false
    @selectedgroup = 1


    self.caption = "Arthur's Adventures v#{VERSION}"
    
    # initialize Resources
    @resources = Resources.new(self)
    
    # Fonts
    @fonts = {}
    @fonts[:default] = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @fonts[:small] = Gosu::Font.new(self, Gosu::default_font_name, 14)
    @fonts[:title] = Gosu::Font.new(self, Gosu::default_font_name, 45)
    @fonts[:credits] = Gosu::Font.new(self, Gosu::default_font_name, 30)
    
    # Images
    @backgrounds = {}
    @backgrounds[:intro]         = @resources.background("intro.png")
    @backgrounds[:title_screen]  = @resources.background("titlescreenv5.png")
    @backgrounds[:pause_screen]  = @resources.background("pausescreen1.png")
    @backgrounds[:shop_screen]   = @resources.background("shopscreen1.png")
    @backgrounds[:how_to_page_1] = @resources.background("htpgp1.png")
    @backgrounds[:how_to_page_2] = @resources.background("htpgp2.png")
    @backgrounds[:how_to_page_3] = @resources.background("htpgp3.png")
    @backgrounds[:how_to_page_4] = @resources.background("htpgp4.png")
    @backgrounds[:credits]       = @resources.background("credits.png")
    
    # Images
    @images = {}
    @images[:menu_icon] = @resources.image("items/dagger4-2.png", true)
    
    # SFX
    @sfx = {}
    @sfx[:menu_move]         = @resources.sfx("menumovesound.wav")
    @sfx[:menu_press_button] = @resources.sfx("bpress.wav")
    @sfx[:pause_button]      = @resources.sfx("pausesound.wav")
    @sfx[:unpause_button]    = @resources.sfx("unpausesound.wav")
    @sfx[:error]             = @resources.sfx("errorsound.wav")
    @sfx[:buy_item]          = @resources.sfx("buyitem1.wav")
    # @buyitemsound = Gosu::Sample.new(self, "data/sfx/buyitem1.wav")
    
    # TODO: pack in hash @icon_pos or something
    @title_screen_icon_pos = 1
    @pause_screen_icon_pos = 1
    @shop_screen_icon_pos = 1

    @how_to_page = 1
    @fps_check = FPSCounter.new()
    # Colors
    @colors = {}
    @colors[:hp_bar] = @resources.color(:red)
    @colors[:hp_bar2] = @resources.color(248, 251, 4)
    @colors[:mp_bar] = @resources.color(:green)
    @colors[:mp_bar2] = @resources.color(248, 251, 4)
    
    # Songs
    load_music
    @songs[:title_screen].play(looping = true)
    
    # Scrolling is stored as the position of the top left corner of the screen.
    @screen_x = @screen_y = 0


    @arthur = Arthur.new(self, 400, 100)
    
    @players = []
    @players << Player.new("Player 1", @arthur)
    # TODO: maybe a 2nd player could join to move enemies? that would be neat
  end


  def update
    # TODO: use symbol instead of numbers
    return if @game_mode != 2

    $touchingshop = 0   
    
    move_x = 0
    move_x -= 5 and @rannum = (rand 100)+1 if button_down? Button::KbLeft 

    move_x -= 5 and @rannum = (rand 100)+1 if button_down? Button::GpLeft
    move_x += 5 and @rannum = (rand 100)+1 if button_down? Button::KbRight
    move_x += 5 and @rannum = (rand 100)+1 if button_down? Button::GpRight

    #if @rannum == 100 then @menumovesound.play end

    @arthur.update(move_x)
    @arthur.collect_golds(@map.golds)
    @arthur.collect_shops(@map.shops)
    @arthur.collect_helmets(@map.helmets)
    @arthur.collect_firecrystals(@map.firecrystals)
    @arthur.collect_firebooks(@map.firebooks)
    @arthur.collect_icecrystals(@map.icecrystals)
    @arthur.collect_icebooks(@map.icebooks)
    @arthur.collect_lightningcrystals(@map.lightningcrystals)
    @arthur.collect_lightningbooks(@map.lightningbooks)
    @arthur.collect_earthcrystals(@map.earthcrystals)
    @arthur.collect_earthbooks(@map.earthbooks)
    @arthur.collect_evilbooks(@map.evilbooks)
    @arthur.collect_swordsandgreyshields(@map.swordsandgreyshields)
    @arthur.collect_groundareagates(@map.groundareagates)
    @arthur.collect_bluepotions(@map.bluepotions)
    @arthur.collect_redpotions(@map.redpotions)
    @arthur.collect_goldpotions(@map.goldpotions)    
    @arthur.collect_greenpotions(@map.greenpotions)    
    @arthur.hit_checkpoint(@map.checkpoints)
    @arthur.hit_fires(@map.fires)
    @arthur.hit_snakes(@map.snakes)
    @arthur.collect_greyshields(@map.greyshields)
    @arthur.collect_powerupswords(@map.powerupswords)


    # Scrolling follows player
    @screen_x = [[$x - @gamexres/2, 0].max, @map.width * 50 - @gamexres].min
    @screen_y = [[$y - @gameyres/2, 0].max, @map.height * 50 - @gameyres].min
  end


  def draw
    if @game_mode == 1
      @titlescreenimage.draw(0, 0, 0)
      #@titlefont1.draw("Press Spacebar or Start Button to Make Selection" , 200, 580,1, 1.0, 1.0, 0xffffffff)
      @fontsmall.draw("V0.4" , 1230, @gameyres -20,1, 1.0, 1.0, 0xffffffff)
      if @title_screen_icon_pos == 1 then   @menuicon.draw(450, 190, 0) end
      if @title_screen_icon_pos == 2 then   @menuicon.draw(450, 245, 0) end
      if @title_screen_icon_pos == 3 then   @menuicon.draw(450, 305, 0) end
      if @title_screen_icon_pos == 4 then   @menuicon.draw(450, 365, 0) end
      if @title_screen_icon_pos == 5 then   @menuicon.draw(450, 425, 0) end
      if @title_screen_icon_pos == 6 then   @menuicon.draw(450, 480, 0) end
    end

    if @game_mode == 6
      @creditspage.draw(0, 0, 0)
    end 

    if @game_mode == 5 then
      @howtoplayguide[@how_to_page-1].draw(0, 0, 0) if @how_to_page > 0
    end 

    if @game_mode == 0
      $titlescreenmusicogg.play(looping = true)
      @game_mode = 1
      @pause_screen_icon_pos = 1
    end

    if @game_mode == 10
      $titlescreenmusicogg.stop
      @arthur.setnewgamevars

      if not @loaded_stuff then
        $normalareatileset = Image.load_tiles(self, "data/tiles/normalrealmtileset.png", 60, 60, true)
        $fireareatileset = Image.load_tiles(self, "data/tiles/firerealmtileset.png", 60, 60, true)
        $iceareatileset = Image.load_tiles(self, "data/tiles/icerealmtileset3.png", 60, 60, true)
        $lightningareatileset = Image.load_tiles(self, "data/tiles/lightningrealmtileset.png", 60, 60, true)
        $groundareatileset = Image.load_tiles(self, "data/tiles/groundrealmtileset.png", 60, 60, true)
        $desertareatileset = Image.load_tiles(self, "data/tiles/groundrealmtileset.png", 60, 60, true)
        $evilareatileset = Image.load_tiles(self, "data/tiles/evilrealmtileset.png", 60, 60, true)
  
        @currentareabkimage = Image.new(self, "data/backgrounds/blank.png", true)
        @area1bk = Image.new(self, "data/backgrounds/area1bk.png", true)
        @area2bk = Image.new(self, "data/backgrounds/area2bk.png", true)
        @area3bk = Image.new(self, "data/backgrounds/area3bk.png", true)
        @area4bk = Image.new(self, "data/backgrounds/area4bk.png", true)
        @area5bk = Image.new(self, "data/backgrounds/area5bk.png", true)
        @area6bk = Image.new(self, "data/backgrounds/area6bk.png", true)
        @area7bk = Image.new(self, "data/backgrounds/area7bk.png", true)
        @area8bk = Image.new(self, "data/backgrounds/area8bk.png", true)
        @area9bk = Image.new(self, "data/backgrounds/area9bk.png", true)
        @evilareabk = Image.new(self, "data/backgrounds/area9bk.png", true)
        @fireareabk = Image.new(self, "data/backgrounds/firedungeonbk.png", true)
        @groundareabk = Image.new(self, "data/backgrounds/grounddungeonbk.png", true)
        @iceareabk = Image.new(self, "data/backgrounds/icedungeonbk.png", true)
        @lightningareabk = Image.new(self, "data/backgrounds/lightningdungeonbk.png", true)

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

      # TODO: extract maps into hash
      @map = Map.new(self, "data/maps/template.map")

      $area1map = Map.new(self, "data/maps/area1.map")
      $area2map = Map.new(self, "data/maps/area2.map")
      $area3map = Map.new(self, "data/maps/area3.map")
      $area4map = Map.new(self, "data/maps/area4.map")
      $area5map = Map.new(self, "data/maps/area5.map")
      $area6map = Map.new(self, "data/maps/area6.map")
      $area7map = Map.new(self, "data/maps/area7.map")
      $area8map = Map.new(self, "data/maps/area8.map")
      $area9map = Map.new(self, "data/maps/area9.map")
      $fireareamap = Map.new(self, "data/maps/firedungeon.map")
      $iceareamap = Map.new(self, "data/maps/icedungeon.map")
      $lightningareamap = Map.new(self, "data/maps/lightningdungeon.map")
      $groundareamap = Map.new(self, "data/maps/grounddungeon.map")
      $evilareamap = Map.new(self, "data/maps/evildungeon.map")

      $normalareamusicogg.play(looping = true) 
      @game_mode = 2
    end

    if @game_mode == 11
      @introimage.draw(0, 0, 0)
      @game_mode = 10  
    end

    if @game_mode == 2 then
      if $x > 12470 and [1,2,4,5,7,8].include?($currentarea)
          #$teleportgatesound.play 
        $x = 25 
        $dir = :right
        $currentarea += 1 
        changemusic
      end

      if $x > 10 and $x < 25 and [2,3,5,6,8,9].include?($currentarea)
        #$teleportgatesound.play 
        $x = 12450 
        $dir = :left
        $currentarea -= 1 
        changemusic
      end

      if $y > 9975 and [1,2,3,4,5,6].include?($currentarea)
        #$teleportgatesound.play 
        $y = 56 
        $currentarea += 3 
        changemusic    
      end


      if $y > 45 and $y < 55 and [4,5,6,7,8,9].include?($currentarea)
        #$teleportgatesound.play 
        $y = 9975 
        $currentarea -= 3 
        changemusic    
      end


      if $currentarea == 15 and $x > 12475 and $x < 12495 and $y < 9950 and $y > 9800
        #$teleportgatesound.play 
        $x = 18760 
        $y = 18699 
        $dir = :right
        $currentarea = 1 
        $normalareamusicogg.play(looping = true)       
      end


      # TODO: extract into a method or hash and use symbols instead of numbers
      @currentareabkimage, @map = \
      case $currentarea
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
      @currentareabkimage.draw(-@screen_x/8, -@screen_y/8, 0)

      @map.draw @screen_x, @screen_y , @gamexres , @gameyres
      @arthur.draw @screen_x, @screen_y 
      @sprlives.draw(1055, -5, 0)
      @font.draw("#{$arthurlives} Lvl: #{@arthur.arthurlevel} " , 1090, 10,1, 1.0, 1.0, 0xffffffff)
      @font.draw("Exp: #{@arthur.arthurexp}" , 1070, 30,1, 1.0, 1.0, 0xffffffff)
      @font.draw("Gold: #{$gold}" , 1070, 50,1, 1.0, 1.0, 0xffffffff)

      #@font.draw("HP: #{@arthur.arthurhp}/#{@arthur.arthurmaxhp} MP: #{@arthur.arthurmp}/#{@arthur.arthurmaxmp} Exp: #{@arthur.arthurexp} WAB: #{@arthur.arthurweaponattboost}%  PDB: #{@arthur.arthurpsysicaldefenceboost}% Level: #{@arthur.arthurlevel} Rubys: #{@arthur.gold} Lives: #{@arthur.arthurlives}", 10, 196,1, 1.0, 1.0, 0xffffffff)
      @fontsmall.draw("#{@arthur.arthurfiremagicboost}%", 202, 35,1, 1.0, 1.0, 0xffffffff)
      @fontsmall.draw("#{@arthur.arthuricemagicboost}%", 237, 35,1, 1.0, 1.0, 0xffffffff)
      @fontsmall.draw("#{@arthur.arthurlightningmagicboost}%", 272, 35,1, 1.0, 1.0, 0xffffffff)
      @fontsmall.draw("#{@arthur.arthurearthmagicboost}%", 307, 35,1, 1.0, 1.0, 0xffffffff)
      @fontsmall.draw("#{@arthur.arthurevilmagicboost}%", 202, 80,1, 1.0, 1.0, 0xffffffff)
      #@font.draw("AD:#{@arthur.arthurdamage} SX:#{@screen_x} SY:#{@screen_y}" , 700, 115,1, 1.0, 1.0, 0xffffffff)
      @font.draw("X:#{$x} Y:#{$y}" , 700, 100,1, 1.0, 1.0, 0xffffffff)

      @fontsmall.draw("Current area:#{$currentarea} selectedgroup:#{@selectedgroup} " , 1000, 100,1, 1.0, 1.0, 0xffffffff)
      #@fontsmall.draw("rannum:#{@rannum} " , 1000, 130,1, 1.0, 1.0, 0xffffffff) 

      @font.draw("#{$numredpotions} ", 45, 11,1, 1.0, 1.0, 0xffffffff)
      @font.draw("#{$numbluepotions} ", 89, 11,1, 1.0, 1.0, 0xffffffff)
      @font.draw("#{$numgoldpotions} ", 134, 11,1, 1.0, 1.0, 0xffffffff)
      @font.draw("#{$numgreenpotions} ", 178, 11,1, 1.0, 1.0, 0xffffffff)

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


      #draw hpenergybar

      draw_line(10,100,@hpbarcolor2,@arthur.arthurmaxhp+10,100,@hpbarcolor2,z=0)
      draw_line(10,101,@hpbarcolor2,@arthur.arthurmaxhp+10,101,@hpbarcolor2,z=0)
      draw_line(10,102,@hpbarcolor2,@arthur.arthurmaxhp+10,102,@hpbarcolor2,z=0)
      draw_line(10,103,@hpbarcolor2,@arthur.arthurmaxhp+10,103,@hpbarcolor2,z=0)
      draw_line(10,104,@hpbarcolor2,@arthur.arthurmaxhp+10,104,@hpbarcolor2,z=0)
      draw_line(10,105,@hpbarcolor2,@arthur.arthurmaxhp+10,105,@hpbarcolor2,z=0)


      draw_line(10,100,@hpbarcolor,@arthur.arthurhp+10,100,@hpbarcolor,z=0)
      draw_line(10,101,@hpbarcolor,@arthur.arthurhp+10,101,@hpbarcolor,z=0)
      draw_line(10,102,@hpbarcolor,@arthur.arthurhp+10,102,@hpbarcolor,z=0)
      draw_line(10,103,@hpbarcolor,@arthur.arthurhp+10,103,@hpbarcolor,z=0)
      draw_line(10,104,@hpbarcolor,@arthur.arthurhp+10,104,@hpbarcolor,z=0)
      draw_line(10,105,@hpbarcolor,@arthur.arthurhp+10,105,@hpbarcolor,z=0)

      #draw mpenergybar
      draw_line(10,110,@mpbarcolor2,@arthur.arthurmaxmp+10,110,@mpbarcolor2,z=0)
      draw_line(10,111,@mpbarcolor2,@arthur.arthurmaxmp+10,111,@mpbarcolor2,z=0)
      draw_line(10,112,@mpbarcolor2,@arthur.arthurmaxmp+10,112,@mpbarcolor2,z=0)
      draw_line(10,113,@mpbarcolor2,@arthur.arthurmaxmp+10,113,@mpbarcolor2,z=0)
      draw_line(10,114,@mpbarcolor2,@arthur.arthurmaxmp+10,114,@mpbarcolor2,z=0)
      draw_line(10,115,@mpbarcolor2,@arthur.arthurmaxmp+10,115,@mpbarcolor2,z=0)

      draw_line(10,110,@mpbarcolor,@arthur.arthurmp+10,110,@mpbarcolor,z=0)
      draw_line(10,111,@mpbarcolor,@arthur.arthurmp+10,111,@mpbarcolor,z=0)
      draw_line(10,112,@mpbarcolor,@arthur.arthurmp+10,112,@mpbarcolor,z=0)
      draw_line(10,113,@mpbarcolor,@arthur.arthurmp+10,113,@mpbarcolor,z=0)
      draw_line(10,114,@mpbarcolor,@arthur.arthurmp+10,114,@mpbarcolor,z=0)
      draw_line(10,115,@mpbarcolor,@arthur.arthurmp+10,115,@mpbarcolor,z=0)

      @fps_check.register_tick
      @font.draw("FPS #{@fps_check.fps}", 1200, 100, 1, 1.0, 1.0, 0xffffff00)
    end

    if @game_mode == 13
      @shopscreenimage.draw(0, 0, 0)
      @font.draw("#{$gold}" , 1110, 27,1, 1.0, 1.0, 0xff000000)
      if @shop_screen_icon_pos == 1 then   @menuicon.draw(400, 230, 0) end
      if @shop_screen_icon_pos == 2 then   @menuicon.draw(400, 275, 0) end
      if @shop_screen_icon_pos == 3 then   @menuicon.draw(400, 325, 0) end
      if @shop_screen_icon_pos == 4 then   @menuicon.draw(400, 365, 0) end
      if @shop_screen_icon_pos == 5 then   @menuicon.draw(400, 405, 0) end
    end

    if @game_mode == 3
      @pausescreenimage.draw(0, 0, 0)
      if @pause_screen_icon_pos == 1 then   @menuicon.draw(400, 220, 0) end
      if @pause_screen_icon_pos == 2 then   @menuicon.draw(400, 310, 0) end
      if @pause_screen_icon_pos == 3 then   @menuicon.draw(400, 395, 0) end
      if @pause_screen_icon_pos == 4 then   @menuicon.draw(400, 480, 0) end
    end

    if @game_mode == 4
      @game_mode = 2
      changemusic  
    end  
  end
  # END draw()


  def button_down(id)
    if @game_mode == 6
      if id == Button::KbSpace or id == Button::GpButton9
        @menupressbuttonsound.play
        @game_mode = 0
      end
    end

    if @game_mode == 5
      if id == Button::KbSpace  or id == Button::GpButton9  then  @menupressbuttonsound.play and @game_mode = @last_game_mode  end

      if id == Button::KbLeft  or id == Button::GpLeft then  @how_to_page -= 1   and @menumovesound.play end
      if id == Button::KbRight  or id == Button::GpRight then  @how_to_page += 1 and @menumovesound.play end

      if @how_to_page == 0 then @how_to_page = 4 end
      if @how_to_page == 5 then @how_to_page = 1 end
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
      if id == Button::KbSpace  or id == Button::GpButton9  and @title_screen_icon_pos == 1 then  @menupressbuttonsound.play and $currentarea = 1 and @game_mode = 11  end
      if id == Button::KbSpace  or id == Button::GpButton9  and @title_screen_icon_pos == 3 then  @menupressbuttonsound.play and @game_mode = 5 and @last_game_mode = 0 end
      if id == Button::KbSpace  or id == Button::GpButton9  and @title_screen_icon_pos == 5 then  @menupressbuttonsound.play and @game_mode = 6 end
      if id == Button::KbEscape  or id == Button::KbSpace  or id == Button::GpButton9  and @title_screen_icon_pos == 6 then close end
      if id == Button::KbEscape  then close end
      if id == Button::KbUp  or id == Button::GpUp then  @title_screen_icon_pos -= 1   and @menumovesound.play end
      if id == Button::KbDown  or id == Button::GpDown then  @title_screen_icon_pos += 1 and @menumovesound.play end

      if @title_screen_icon_pos == 0 then @title_screen_icon_pos = 6 end
      if @title_screen_icon_pos == 7 then @title_screen_icon_pos = 1 end
    end

    # :playing
    if @game_mode == 2
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
  
  def load_music
    @songs = {}
    @songs[:title_screen]   = @resources.song("ArthurTheme.ogg", volume = 0.15)
    @songs[:normal_area]    = @resources.song("NormalRealm.ogg", 0.15)
    @songs[:fire_area]      = @resources.song("FireRealm.mid", 0.15)
    @songs[:ice_area]       = @resources.song("IceRealm.ogg", 0.20)
    @songs[:lightning_area] = @resources.song("NormalRealm.ogg", 0.15)
    @songs[:ground_area]    = @resources.song("PoisonRealm.ogg", 0.60)
    @songs[:evil_area]      = @resources.song("EvilRealm.mid", 0.60)
  end
  
end # end class Game