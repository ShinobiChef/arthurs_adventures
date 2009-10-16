# The human player playing the game, not Arthur the hero
# Will be the base for possibly multiplayer
class Player
  # Each Player embodies one character
  attr_accessor :name, :character
  
  def initialize(name, character = nil)
    @name, @character = name, character
  end
end