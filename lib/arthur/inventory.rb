class Artventure::Creature::Inventory
  def initialize(game, creature)
    @game = game
    @creature = creature
    @stuff = Hash.new(0)
  end
  
  def <<(collectable)
    @stuff[collectable] += 1
    @game.map.collectables.delete(collectables)
    collectable.collected!
  end
  
  def remove(collectable)
    @stuff[collectable] -= 1
    @stuff[collectable] = 0 if @stuff[collectable] < 0
    @game.map.collectables << collectable
    # drop at current creature's position
    collectable.x, collectable.y = creature.x, creature.y    
  end
end