# Arthur's Adventures
 
begin
  # In case you use Gosu via rubygems.
  require 'rubygems'
rescue LoadError
  # In case you don't.
end

require 'items'  
require 'arthur'  
require 'map' 
require 'gosu'
include Gosu
 
module Tiles
  Grass = 0
  Earth = 1
  Bstone = 2
  Bstoneg = 3
  Ystone = 4
  Ystoneg = 5
  Rstoneg = 6
  Rstone = 7
  Earthw1 = 8
  Ystonew1 = 9
  Rstonew1 = 10
  Earthw2 = 11
  Earthw3 = 12
  Earthw4 = 13
  Ystonew2 = 14
  Ystonew3 = 15
  Ystonew4 = 16
  Rstonew2 = 17
  Rstonew3 = 18
  Rstonew4 = 19
  Istonew2 = 20
  Istonew3 = 21
  Istonew4 = 22
  Istonew1 = 23
end


 


class Game < Window
  attr_reader :map, :gamexres, :gameyres,:gamemode,:loadedstuff,
  :titlescreeniconpos,:pausescreeniconpos,:htpgpagenum,:lastgamemode,:shopscreeniconpos,:selectedgroup,:rannum
 
  def initialize
    @gamexres,@gameyres = 1280,800
    super(@gamexres,@gameyres, true)
    #@gamexres,@gameyres = 1270,790
    #super(@gamexres,@gameyres, false)
    @rannum = 1
    $lastgamemode = 1
    $gamemode = 1
    $loadedstuff = 0
    $selectedgroup = 1
    
        
    self.caption = "Arthur's Adventures V0.4"
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @fontsmall = Gosu::Font.new(self, Gosu::default_font_name, 14)
    @titlefont1 = Gosu::Font.new(self, Gosu::default_font_name, 45)
    @creditsfont = Gosu::Font.new(self, Gosu::default_font_name, 30)
    @titlescreenimage = Image.new(self, "data/backgrounds/titlescreenv5.png", true)
    @introimage = Image.new(self, "data/backgrounds/intro.png", true)
    @pausescreenimage = Image.new(self, "data/backgrounds/pausescreen1.png", true)
    @shopscreenimage = Image.new(self, "data/backgrounds/shopscreen1.png", true)
    @howtoplayguidepage1 = Image.new(self, "data/backgrounds/htpgp1.png", true)
    @howtoplayguidepage2 = Image.new(self, "data/backgrounds/htpgp2.png", true)
    @howtoplayguidepage3 = Image.new(self, "data/backgrounds/htpgp3.png", true)
    @howtoplayguidepage4 = Image.new(self, "data/backgrounds/htpgp4.png", true)
    @creditspage = Image.new(self, "data/backgrounds/credits.png", true)
        @menuicon = Image.new(self, "data/items/dagger4-2.png", true)
        
        
    
    @menumovesound = Gosu::Sample.new(self, "data/sfx/menumovesound.wav")
    @menupressbuttonsound = Gosu::Sample.new(self, "data/sfx/bpress.wav")
    @pausebuttonsound = Gosu::Sample.new(self, "data/sfx/pausesound.wav")
    @unpausebuttonsound = Gosu::Sample.new(self, "data/sfx/unpausesound.wav")
     @errorsound = Gosu::Sample.new(self, "data/sfx/errorsound.wav")
     @buyitemsound = Gosu::Sample.new(self, "data/sfx/buyitem1.wav")
    
    $titlescreeniconpos = 1
    $pausescreeniconpos = 1
    $htpgpagenum = 1
    $shopscreeniconpos = 1
    @fps_check = FPSCounter.new()
    @cptn = Arthur.new(self, 400, 100)
    


   
@hpbarcolor = Gosu::Color.new(0xff000000)
    @hpbarcolor.red = 255
    @hpbarcolor.green = 0
    @hpbarcolor.blue = 0
    
    @hpbarcolor2 = Gosu::Color.new(0xff000000)
    @hpbarcolor2.red = 248
    @hpbarcolor2.green = 251
    @hpbarcolor2.blue = 4

@mpbarcolor = Gosu::Color.new(0xff000000)
    @mpbarcolor.red = 0
    @mpbarcolor.green = 0
    @mpbarcolor.blue = 255
    
    @mpbarcolor2 = Gosu::Color.new(0xff000000)
    @mpbarcolor2.red = 9
    @mpbarcolor2.green = 198
    @mpbarcolor2.blue = 253


 $titlescreenmusicogg.volume = 0.15
 $normalareamusicogg.volume = 0.15
    $titlescreenmusicogg.play(looping = true)       
    # Scrolling is stored as the position of the top left corner of the screen.
    @screen_x = @screen_y = 0
  end
  
  def changemusic
if $currentarea == 1 then  $normalareamusicogg.play(looping = true) end
if $currentarea == 2 then  $normalareamusicogg.play(looping = true) end
if $currentarea == 3 then  $normalareamusicogg.play(looping = true) end
if $currentarea == 4 then  $normalareamusicogg.play(looping = true) end
if $currentarea == 5 then  $normalareamusicogg.play(looping = true) end
if $currentarea == 6 then  $iceareamusicogg.play(looping = true) end
if $currentarea == 7 then  $fireareamusicogg.play(looping = true) end
if $currentarea == 8 then  $normalareamusicogg.play(looping = true) end
if $currentarea == 9 then  $evilareamusicogg.play(looping = true) end

 end
 
 def pausemusic
      if $currentarea == 1 then  $normalareamusicogg.pause end
      if $currentarea == 2 then  $normalareamusicogg.pause end
      if $currentarea == 3 then  $normalareamusicogg.pause end
      if $currentarea == 4 then  $normalareamusicogg.pause end
      if $currentarea == 5 then  $normalareamusicogg.pause end
      if $currentarea == 6 then  $iceareamusicogg.pause end
      if $currentarea == 7 then  $fireareamusicogg.pause end
      if $currentarea == 8 then  $normalareamusicogg.pause end
      if $currentarea == 9 then  $evilareamusicogg.pause end
      if $currentarea == 10 then  $fireareamusicogg.pause end
      if $currentarea == 11 then  $iceareamusicogg.pause end
      if $currentarea == 12 then  $lightningareamusicogg.pause end
      if $currentarea == 13 then  $groundareamusicogg.pause end
      if $currentarea == 15 then  $evilareamusicogg.pause end


 end
  def update
$touchingshop = 0   


if $gamemode == 2 then
      
    move_x = 0
    move_x -= 5 and @rannum = (rand 100)+1 if button_down? Button::KbLeft 
    
    move_x -= 5 and @rannum = (rand 100)+1 if button_down? Button::GpLeft
    move_x += 5 and @rannum = (rand 100)+1 if button_down? Button::KbRight
    move_x += 5 and @rannum = (rand 100)+1 if button_down? Button::GpRight
    
     #if @rannum == 100 then @menumovesound.play end
     
    @cptn.update(move_x)
    @cptn.collect_golds(@map.golds)
    @cptn.collect_shops(@map.shops)
    @cptn.collect_helmets(@map.helmets)
    @cptn.collect_firecrystals(@map.firecrystals)
    @cptn.collect_firebooks(@map.firebooks)
    @cptn.collect_icecrystals(@map.icecrystals)
    @cptn.collect_icebooks(@map.icebooks)
    @cptn.collect_lightningcrystals(@map.lightningcrystals)
    @cptn.collect_lightningbooks(@map.lightningbooks)
    @cptn.collect_earthcrystals(@map.earthcrystals)
    @cptn.collect_earthbooks(@map.earthbooks)
    @cptn.collect_evilbooks(@map.evilbooks)
    @cptn.collect_swordsandgreyshields(@map.swordsandgreyshields)
    @cptn.collect_groundareagates(@map.groundareagates)
    @cptn.collect_bluepotions(@map.bluepotions)
    @cptn.collect_redpotions(@map.redpotions)
    @cptn.collect_goldpotions(@map.goldpotions)    
    @cptn.collect_greenpotions(@map.greenpotions)    
    @cptn.hit_checkpoint(@map.checkpoints)
    @cptn.hit_fires(@map.fires)
    @cptn.hit_snakes(@map.snakes)
    @cptn.collect_greyshields(@map.greyshields)
    @cptn.collect_powerupswords(@map.powerupswords)
    
    
    # Scrolling follows player
    @screen_x = [[$x - @gamexres/2, 0].max, @map.width * 50 - @gamexres].min
    @screen_y = [[$y - @gameyres/2, 0].max, @map.height * 50 - @gameyres].min
  end
  
  end
  def draw

if $gamemode == 1 then
  
  @titlescreenimage.draw(0, 0, 0)
    #@titlefont1.draw("Press Spacebar or Start Button to Make Selection" , 200, 580,1, 1.0, 1.0, 0xffffffff)
    @fontsmall.draw("V0.4" , 1230, @gameyres -20,1, 1.0, 1.0, 0xffffffff)
  if $titlescreeniconpos == 1 then   @menuicon.draw(450, 190, 0) end
if $titlescreeniconpos == 2 then   @menuicon.draw(450, 245, 0) end
if $titlescreeniconpos == 3 then   @menuicon.draw(450, 305, 0) end
if $titlescreeniconpos == 4 then   @menuicon.draw(450, 365, 0) end
if $titlescreeniconpos == 5 then   @menuicon.draw(450, 425, 0) end
if $titlescreeniconpos == 6 then   @menuicon.draw(450, 480, 0) end
  end
 
if $gamemode == 6 then
  
  
  @creditspage.draw(0, 0, 0)
  
    
  
  end 


if $gamemode == 5 then
  
  if $htpgpagenum == 1 then @howtoplayguidepage1.draw(0, 0, 0) end
  if $htpgpagenum == 2 then @howtoplayguidepage2.draw(0, 0, 0) end
  if $htpgpagenum == 3 then @howtoplayguidepage3.draw(0, 0, 0) end
  if $htpgpagenum == 4 then @howtoplayguidepage4.draw(0, 0, 0) end
  
    
  
  end 
  
if $gamemode == 0 then
  $titlescreenmusicogg.play(looping = true)
  $gamemode = 1
  $pausescreeniconpos = 1
  end


if $gamemode == 10 then
  
$titlescreenmusicogg.stop
@cptn.setnewgamevars

if $loadedstuff == 0 then
$normalareatileset = Image.load_tiles(self, "data/tiles/normalrealmtileset.png", 60, 60, true)
    $fireareatileset = Image.load_tiles(self, "data/tiles/firerealmtileset.png", 60, 60, true)
    $iceareatileset = Image.load_tiles(self, "data/tiles/icerealmtileset3.png", 60, 60, true)
    $lightningareatileset = Image.load_tiles(self, "data/tiles/lightningrealmtileset.png", 60, 60, true)
    $groundareatileset = Image.load_tiles(self, "data/tiles/groundrealmtileset.png", 60, 60, true)
    $desertareatileset = Image.load_tiles(self, "data/tiles/groundrealmtileset.png", 60, 60, true)
    $evilareatileset = Image.load_tiles(self, "data/tiles/evilrealmtileset.png", 60, 60, true)
    

    
    
        
  
 @currentareabkimage = Image.new(self, "data/backgrounds/blank.png", true)
    @area1bk = Image.new(self, "data/backgrounds/area1bk.png", true)
    @area2bk = Image.new(self, "data/backgrounds/area1bk.png", true)
    @area3bk = Image.new(self, "data/backgrounds/area1bk.png", true)
    @area4bk = Image.new(self, "data/backgrounds/area1bk.png", true)
    @area5bk = Image.new(self, "data/backgrounds/area1bk.png", true)
    @area6bk = Image.new(self, "data/backgrounds/area1bk.png", true)
    @area7bk = Image.new(self, "data/backgrounds/area1bk.png", true)
    @area8bk = Image.new(self, "data/backgrounds/area1bk.png", true)
    @area9bk = Image.new(self, "data/backgrounds/area1bk.png", true)
    
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

$loadedstuff = 1
 end
 
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
  $gamemode = 2
  
  
  end

if $gamemode == 11 then
  
  @introimage.draw(0, 0, 0)
    
$gamemode = 10  
  end


if $gamemode == 2 then



  if $currentarea == 1 or $currentarea == 2 or $currentarea == 4 or $currentarea == 5 or $currentarea == 7 or $currentarea == 8 and $x>12470 then 
      #$teleportgatesound.play 
      $x = 25 
      $dir = :right
      $currentarea += 1 

changemusic

    end


if $currentarea == 2 or $currentarea == 3 or $currentarea == 5 or $currentarea == 6 or $currentarea == 8 or $currentarea == 9 and $x>10 and $x<25 then 
      #$teleportgatesound.play 
      $x = 12450 
      $dir = :left
      $currentarea -= 1 

changemusic
    end

  
  if $currentarea == 1 or $currentarea == 2 or $currentarea == 3 or $currentarea == 4 or $currentarea == 5 or $currentarea == 6 and $y>9975  then 
      #$teleportgatesound.play 
      $y = 56 
      $currentarea += 3 
changemusic    
  end
  
  
if $currentarea == 4 or $currentarea == 5 or $currentarea == 6 or $currentarea == 7 or $currentarea == 8 or $currentarea == 9 and $y>45 and $y<55 then 
      #$teleportgatesound.play 
      $y = 9975 
      $currentarea -= 3 
changemusic    
    end


if $currentarea == 15 and $x>12475 and $x<12495 and $y<9950 and $y>9800 then 
      #$teleportgatesound.play 
      $x = 18760 
      $y = 18699 
      $dir = :right
      $currentarea = 1 
      $normalareamusicogg.play(looping = true)       
    end

  
  if $currentarea == 1 then @currentareabkimage = @area1bk and @map = $area1map end
  if $currentarea == 2 then @currentareabkimage = @area2bk and @map = $area2map end
  if $currentarea == 3 then @currentareabkimage = @area3bk and @map = $area3map end
  if $currentarea == 4 then @currentareabkimage = @area4bk and @map = $area4map end
  if $currentarea == 5 then @currentareabkimage = @area5bk and @map = $area5map end
  if $currentarea == 6 then @currentareabkimage = @area6bk and @map = $area6map end
  if $currentarea == 7 then @currentareabkimage = @area7bk and @map = $area7map end
  if $currentarea == 8 then @currentareabkimage = @area8bk and @map = $area8map end
  if $currentarea == 9 then @currentareabkimage = @area9bk and @map = $area9map end
    
    
    
    
    
    @currentareabkimage.draw(-@screen_x/8, -@screen_y/8, 0)
    
    @map.draw @screen_x, @screen_y , @gamexres , @gameyres
    @cptn.draw @screen_x, @screen_y 
    @sprlives.draw(1055, -5, 0)
    @font.draw("#{$arthurlives} Lvl: #{@cptn.arthurlevel} " , 1090, 10,1, 1.0, 1.0, 0xffffffff)
    @font.draw("Exp: #{@cptn.arthurexp}" , 1070, 30,1, 1.0, 1.0, 0xffffffff)
    @font.draw("Gold: #{$gold}" , 1070, 50,1, 1.0, 1.0, 0xffffffff)
    
    #@font.draw("HP: #{@cptn.arthurhp}/#{@cptn.arthurmaxhp} MP: #{@cptn.arthurmp}/#{@cptn.arthurmaxmp} Exp: #{@cptn.arthurexp} WAB: #{@cptn.arthurweaponattboost}%  PDB: #{@cptn.arthurpsysicaldefenceboost}% Level: #{@cptn.arthurlevel} Rubys: #{@cptn.gold} Lives: #{@cptn.arthurlives}", 10, 196,1, 1.0, 1.0, 0xffffffff)
    @fontsmall.draw("#{@cptn.arthurfiremagicboost}%", 202, 35,1, 1.0, 1.0, 0xffffffff)
    @fontsmall.draw("#{@cptn.arthuricemagicboost}%", 237, 35,1, 1.0, 1.0, 0xffffffff)
    @fontsmall.draw("#{@cptn.arthurlightningmagicboost}%", 272, 35,1, 1.0, 1.0, 0xffffffff)
    @fontsmall.draw("#{@cptn.arthurearthmagicboost}%", 307, 35,1, 1.0, 1.0, 0xffffffff)
    @fontsmall.draw("#{@cptn.arthurevilmagicboost}%", 202, 80,1, 1.0, 1.0, 0xffffffff)
    #@font.draw("AD:#{@cptn.arthurdamage} SX:#{@screen_x} SY:#{@screen_y}" , 700, 115,1, 1.0, 1.0, 0xffffffff)
    @font.draw("X:#{$x} Y:#{$y}" , 700, 100,1, 1.0, 1.0, 0xffffffff)
    
    @fontsmall.draw("Current area:#{$currentarea} selectedgroup:#{$selectedgroup} " , 1000, 100,1, 1.0, 1.0, 0xffffffff)
    #@fontsmall.draw("rannum:#{@rannum} " , 1000, 130,1, 1.0, 1.0, 0xffffffff) 
     
    @font.draw("#{$numredpotions} ", 45, 11,1, 1.0, 1.0, 0xffffffff)
    @font.draw("#{$numbluepotions} ", 89, 11,1, 1.0, 1.0, 0xffffffff)
    @font.draw("#{$numgoldpotions} ", 134, 11,1, 1.0, 1.0, 0xffffffff)
    @font.draw("#{$numgreenpotions} ", 178, 11,1, 1.0, 1.0, 0xffffffff)
    
    if $selectedgroup ==1 then @selectedgroup1box.draw(10, 0, 0) end        
    if $selectedgroup ==2 then @selectedgroup2box.draw(200, 0, 0) end        
    if $selectedgroup ==3 then @selectedgroup3box.draw(342, 0, 0) end        
    if $selectedgroup ==4 then @selectedgroup4box.draw(472, 0, 0) end        
    if $selectedgroup ==5 then @selectedgroup5box.draw(596, 0, 0) end        
    
if $numredpotions>0 then @sprlrp.draw(8, -15, 0) else @sprlgreyp.draw(8, -15, 0) end        
if $numbluepotions>0 then @sprlbp.draw(52, -15, 0) else @sprlgreyp.draw(52, -15, 0) end        
if $numgoldpotions>0 then @sprlgp.draw(96, -15, 0) else @sprlgreyp.draw(96, -15, 0) end        
if $numgreenpotions>0 then @sprlgrp.draw(140, -15, 0) else @sprlgreyp.draw(140, -15, 0) end        

if @cptn.arthurfiremagicboost>0 then @sprbookfire.draw(195, -5, 0) else @sprbookgrey.draw(195, -5, 0) end        
if @cptn.arthuricemagicboost>0 then @sprbookice.draw(230, -5, 0) else @sprbookgrey.draw(230, -5, 0) end        
if @cptn.arthurlightningmagicboost>0 then @sprbooklightning.draw(265, -5, 0) else @sprbookgrey.draw(265, -5, 0) end        
if @cptn.arthurearthmagicboost>0 then @sprbookground.draw(300, -5, 0) else @sprbookgrey.draw(300, -5, 0) end        
if @cptn.arthurevilmagicboost>0 then @sprbookevil.draw(195, 40, 0) else @sprbookgrey.draw(195, 40, 0) end        


if @cptn.arthurweapon1>0 then @sprweapon1.draw(345, -5, 0) else @sprweapon1grey.draw(345, -5, 0) end        
if @cptn.arthurweapon2>0 then @sprweapon2.draw(380, -5, 0) else @sprweapon2grey.draw(380, -5, 0) end        
if @cptn.arthurweapon3>0 then @sprweapon3.draw(415, -5, 0) else @sprweapon3grey.draw(415, -5, 0) end        
if @cptn.arthurweapon4>0 then @sprweapon4.draw(345, 40, 0) else @sprweapon4grey.draw(345, 40, 0) end        
if @cptn.arthurweapon5>0 then @sprweapon5.draw(380, 40, 0) else @sprweapon5grey.draw(380, 40, 0) end        
if @cptn.arthurweapon6>0 then @sprweapon6.draw(415, 40, 0) else @sprweapon6grey.draw(415, 40, 0) end        

if @cptn.arthurarmour1>0 then @sprarmour1.draw(485, 5, 0) else @sprarmour7.draw(485, 5, 0) end        
if @cptn.arthurarmour2>0 then @sprarmour2.draw(520, 5, 0) else @sprarmour7.draw(520, 5, 0) end        
if @cptn.arthurarmour3>0 then @sprarmour3.draw(555, 5, 0) else @sprarmour7.draw(555, 5, 0) end        
if @cptn.arthurarmour4>0 then @sprarmour4.draw(485, 50, 0) else @sprarmour7.draw(485, 50, 0) end        
if @cptn.arthurarmour5>0 then @sprarmour5.draw(520, 50, 0) else @sprarmour7.draw(520, 50, 0) end        
if @cptn.arthurarmour6>0 then @sprarmour6.draw(555, 50, 0) else @sprarmour7.draw(555, 50, 0) end        


if @cptn.arthurboots1>0 then @sprboots1.draw(600, 5, 0) else @sprboots7.draw(600, 5, 0) end        
if @cptn.arthurboots2>0 then @sprboots2.draw(635, 5, 0) else @sprboots7.draw(635, 5, 0) end        
if @cptn.arthurboots3>0 then @sprboots3.draw(670, 5, 0) else @sprboots7.draw(670, 5, 0) end        
if @cptn.arthurboots4>0 then @sprboots4.draw(600, 50, 0) else @sprboots7.draw(600, 50, 0) end        
if @cptn.arthurboots5>0 then @sprboots5.draw(635, 50, 0) else @sprboots7.draw(635, 50, 0) end        
if @cptn.arthurboots6>0 then @sprboots6.draw(670, 50, 0) else @sprboots7.draw(670, 50, 0) end        

if @cptn.arthurstatus1>0 then @sprstatus1.draw(30, 65, 0) end        
if @cptn.arthurstatus2>0 then @sprstatus2.draw(55, 65, 0) end        
if @cptn.arthurstatus3>0 then @sprstatus3.draw(80, 65, 0) end        
if @cptn.arthurstatus4>0 then @sprstatus4.draw(105, 65, 0) end        
if @cptn.arthurstatus5>0 then @sprstatus5.draw(130, 65, 0) end        
if @cptn.arthurstatus6>0 then @sprstatus6.draw(155, 65, 0) end        


#draw hpenergybar

draw_line(10,100,@hpbarcolor2,@cptn.arthurmaxhp+10,100,@hpbarcolor2,z=0)
draw_line(10,101,@hpbarcolor2,@cptn.arthurmaxhp+10,101,@hpbarcolor2,z=0)
draw_line(10,102,@hpbarcolor2,@cptn.arthurmaxhp+10,102,@hpbarcolor2,z=0)
draw_line(10,103,@hpbarcolor2,@cptn.arthurmaxhp+10,103,@hpbarcolor2,z=0)
draw_line(10,104,@hpbarcolor2,@cptn.arthurmaxhp+10,104,@hpbarcolor2,z=0)
draw_line(10,105,@hpbarcolor2,@cptn.arthurmaxhp+10,105,@hpbarcolor2,z=0)


draw_line(10,100,@hpbarcolor,@cptn.arthurhp+10,100,@hpbarcolor,z=0)
draw_line(10,101,@hpbarcolor,@cptn.arthurhp+10,101,@hpbarcolor,z=0)
draw_line(10,102,@hpbarcolor,@cptn.arthurhp+10,102,@hpbarcolor,z=0)
draw_line(10,103,@hpbarcolor,@cptn.arthurhp+10,103,@hpbarcolor,z=0)
draw_line(10,104,@hpbarcolor,@cptn.arthurhp+10,104,@hpbarcolor,z=0)
draw_line(10,105,@hpbarcolor,@cptn.arthurhp+10,105,@hpbarcolor,z=0)

#draw mpenergybar
draw_line(10,110,@mpbarcolor2,@cptn.arthurmaxmp+10,110,@mpbarcolor2,z=0)
draw_line(10,111,@mpbarcolor2,@cptn.arthurmaxmp+10,111,@mpbarcolor2,z=0)
draw_line(10,112,@mpbarcolor2,@cptn.arthurmaxmp+10,112,@mpbarcolor2,z=0)
draw_line(10,113,@mpbarcolor2,@cptn.arthurmaxmp+10,113,@mpbarcolor2,z=0)
draw_line(10,114,@mpbarcolor2,@cptn.arthurmaxmp+10,114,@mpbarcolor2,z=0)
draw_line(10,115,@mpbarcolor2,@cptn.arthurmaxmp+10,115,@mpbarcolor2,z=0)

draw_line(10,110,@mpbarcolor,@cptn.arthurmp+10,110,@mpbarcolor,z=0)
draw_line(10,111,@mpbarcolor,@cptn.arthurmp+10,111,@mpbarcolor,z=0)
draw_line(10,112,@mpbarcolor,@cptn.arthurmp+10,112,@mpbarcolor,z=0)
draw_line(10,113,@mpbarcolor,@cptn.arthurmp+10,113,@mpbarcolor,z=0)
draw_line(10,114,@mpbarcolor,@cptn.arthurmp+10,114,@mpbarcolor,z=0)
draw_line(10,115,@mpbarcolor,@cptn.arthurmp+10,115,@mpbarcolor,z=0)

@fps_check.register_tick
    @font.draw("FPS #{@fps_check.fps}", 1200, 100, 1, 1.0, 1.0, 0xffffff00)
end

if $gamemode == 13 then
  
  @shopscreenimage.draw(0, 0, 0)
   @font.draw("#{$gold}" , 1110, 27,1, 1.0, 1.0, 0xff000000)
if $shopscreeniconpos == 1 then   @menuicon.draw(400, 230, 0) end
if $shopscreeniconpos == 2 then   @menuicon.draw(400, 275, 0) end
if $shopscreeniconpos == 3 then   @menuicon.draw(400, 325, 0) end
if $shopscreeniconpos == 4 then   @menuicon.draw(400, 365, 0) end
if $shopscreeniconpos == 5 then   @menuicon.draw(400, 405, 0) end
  
  end


if $gamemode == 3 then
  
  @pausescreenimage.draw(0, 0, 0)
   
if $pausescreeniconpos == 1 then   @menuicon.draw(400, 220, 0) end
if $pausescreeniconpos == 2 then   @menuicon.draw(400, 310, 0) end
if $pausescreeniconpos == 3 then   @menuicon.draw(400, 395, 0) end
if $pausescreeniconpos == 4 then   @menuicon.draw(400, 480, 0) end
  
  end

if $gamemode == 4 then
  
  $gamemode = 2
changemusic  
  end

end

 
  def button_down(id)

if $gamemode == 6 then   

if id == Button::KbSpace  or id == Button::GpButton9  then  @menupressbuttonsound.play and $gamemode = 0  end


end


if $gamemode == 5 then   

if id == Button::KbSpace  or id == Button::GpButton9  then  @menupressbuttonsound.play and $gamemode = $lastgamemode  end

if id == Button::KbLeft  or id == Button::GpLeft then  $htpgpagenum -= 1   and @menumovesound.play end
if id == Button::KbRight  or id == Button::GpRight then  $htpgpagenum += 1 and @menumovesound.play end

if $htpgpagenum == 0 then $htpgpagenum = 4 end
  if $htpgpagenum == 5 then $htpgpagenum = 1 end
end

if $gamemode == 13 then   

if id == Button::KbJ  or id == Button::GpButton2   and $shopscreeniconpos == 1 then   if $gold<50 then @errorsound.play end end 
if id == Button::KbJ  or id == Button::GpButton2   and $shopscreeniconpos == 1 then   if $gold>49 then $numredpotions += 1 and $gold -= 50 and @buyitemsound.play end end 
if id == Button::KbJ  or id == Button::GpButton2   and $shopscreeniconpos == 2 then   if $gold<50 then @errorsound.play end end
if id == Button::KbJ  or id == Button::GpButton2   and $shopscreeniconpos == 2 then  if $gold>49 then $numbluepotions += 1 and $gold -= 50 and @buyitemsound.play end  end
if id == Button::KbJ  or id == Button::GpButton2   and $shopscreeniconpos == 3 then   if $gold<50 then @errorsound.play end end
if id == Button::KbJ  or id == Button::GpButton2   and $shopscreeniconpos == 3 then  if $gold>149 then $numgoldpotions += 1 and $gold -= 150 and @buyitemsound.play end end
if id == Button::KbJ  or id == Button::GpButton2   and $shopscreeniconpos == 4 then   if $gold<80 then @errorsound.play end end
if id == Button::KbJ  or id == Button::GpButton2   and $shopscreeniconpos == 4 then  if $gold>79 then $numgreenpotions += 1 and $gold -= 80 and @buyitemsound.play end  end
if id == Button::KbJ  or id == Button::GpButton2   and $shopscreeniconpos == 5 then   if $gold<1000 then @errorsound.play end end
if id == Button::KbJ  or id == Button::GpButton2  and $shopscreeniconpos == 5 then  if $gold>999 then $arthurlives += 1 and $gold -= 1000 and @buyitemsound.play end  end
if id == Button::KbK  or id == Button::GpButton1  and @menupressbuttonsound.play then  $gamemode = 4  end

if id == Button::KbUp  or id == Button::GpUp then  $shopscreeniconpos -= 1   and @menumovesound.play end
if id == Button::KbDown  or id == Button::GpDown then  $shopscreeniconpos += 1 and @menumovesound.play end

if $shopscreeniconpos == 0 then $shopscreeniconpos = 5 end
  if $shopscreeniconpos == 6 then $shopscreeniconpos = 1 end
end


if $gamemode == 3 then   

if id == Button::KbSpace  or id == Button::GpButton9  and @unpausebuttonsound.play and $pausescreeniconpos == 1 then  $gamemode = 4  end
if id == Button::KbSpace  or id == Button::GpButton9  and @menupressbuttonsound.play and $pausescreeniconpos == 2 then  $gamemode = 5 and $lastgamemode = 12  end
if id == Button::KbSpace  or id == Button::GpButton9  and @menupressbuttonsound.play and $pausescreeniconpos == 4 then  $gamemode = 0  end

if id == Button::KbUp  or id == Button::GpUp then  $pausescreeniconpos -= 1   and @menumovesound.play end
if id == Button::KbDown  or id == Button::GpDown then  $pausescreeniconpos += 1 and @menumovesound.play end

if $pausescreeniconpos == 0 then $pausescreeniconpos = 4 end
  if $pausescreeniconpos == 5 then $pausescreeniconpos = 1 end
end




if $gamemode == 1 then   
if id == Button::KbSpace  or id == Button::GpButton9  and $titlescreeniconpos == 1 then  @menupressbuttonsound.play and $currentarea = 1 and $gamemode = 11  end
if id == Button::KbSpace  or id == Button::GpButton9  and $titlescreeniconpos == 3 then  @menupressbuttonsound.play and $gamemode = 5 and $lastgamemode = 0 end
if id == Button::KbSpace  or id == Button::GpButton9  and $titlescreeniconpos == 5 then  @menupressbuttonsound.play and $gamemode = 6 end
if id == Button::KbEscape  or id == Button::KbSpace  or id == Button::GpButton9  and $titlescreeniconpos == 6 then close end
if id == Button::KbEscape  then close end
if id == Button::KbUp  or id == Button::GpUp then  $titlescreeniconpos -= 1   and @menumovesound.play end
if id == Button::KbDown  or id == Button::GpDown then  $titlescreeniconpos += 1 and @menumovesound.play end


if $titlescreeniconpos == 0 then $titlescreeniconpos = 6 end
  if $titlescreeniconpos == 7 then $titlescreeniconpos = 1 end
end

if $gamemode == 10 then   

end



if $gamemode == 2 then 
    
          
       
    if id== Button::KbUp or id == Button::GpButton2 or id == Button::KbC then @cptn.try_to_jump end
    if id == Button::KbZ or id == Button::GpButton3 or id == Button::KbReturn or id == Button::MsMiddle then @cptn.useitem end
    if id == Button::KbQ or id == Button::KbNumpad9 or id == Button::GpButton5 or id == Button::MsWheelDown and $selectedgroup == 1 then @cptn.changeitemforward end
    if id == Button::KbA or id == Button::KbNumpad3  or id == Button::GpButton4 or id == Button::MsWheelUp and $selectedgroup == 1 then @cptn.changeitembackward end

if id == Button::KbW or id == Button::KbNumpad7 or id == Button::GpButton7 then $selectedgroup += 1 end
    if id == Button::KbS or id == Button::KbNumpad1  or id == Button::GpButton6 then $selectedgroup -= 1 end
    
    if $selectedgroup == 0 then $selectedgroup = 5 end
    if $selectedgroup == 6 then $selectedgroup = 1 end

    if id == Button::KbSpace  or id == Button::GpButton9 then 
pausemusic
@pausebuttonsound.play 
      $gamemode = 3
    end
    
    if id == Button::KbUp  or id == Button::GpUp and $touchingshop == 1 then 
      pausemusic
      @pausebuttonsound.play 
      $gamemode = 13
      end

    if id == Button::KbEscape then $gamemode = 1 and $titlescreenmusicogg.play(looping = true) end
  end

if $gamemode == 12 then   
$gamemode = 3 
end


  end



end


Game.new.show