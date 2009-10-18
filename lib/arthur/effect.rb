# TODO: rethink all the effect models
class Artventure::Creature::Effect
  def initialize(creature, effect_name, modifier = nil)
    @creature = creature
    @effect_name = effect_name
    @modifier = modifier
  end
  
  def apply!
    case effect_name.to_sym
    when :restore_health
      creature.attributes[:health].increase(modifier || creature.max_health)
    when :restore_mana
      creature.attributes[:mana].increase(modifier || creature.max_mana)
    when :restore_status
      # TODO: implement restore status
    when :regenerate
      
    end
  end
end


# TimedEffect.new(@arthur, :poison, :seconds => 10)

# Timed effects have to be checked each frame for updates
class Artventure::Creature::TimedEffect < Effect
  def initialize(creature, options)
    @creature = creature
    @options = options
    @counter = 0
  end
  
  def apply!
  end
  
  def ready?
    @counter += 1
    @counter = 0 if @counter > @options[:every]
    @counter >= @options[:every]
  end
end

# if @arthurmp < @arthurmaxmp then 
#   @arthurmprestore += 1
#   if @arthurmprestore > 250 then @arthurmprestore = 1 and @arthurmp += 1 end
# end
# if @arthurmp > @arthurmaxmp then @arthurmp=@arthurmaxmp end

# Effect.new(@arthur, :regenerate, :mana => {1 => {:seconds => 1}})
# Regenerate.new(@arthur, :mana, 1, :every => 10)
# Poison.new(@arthur, :health, 1, :every => 250)
class Artventure::Creature::Regenerate < TimedEffect
  def initialize(creature, attribute, amount, options = {:every => 250})
    super(creature, options)
    @creature = creature
    @attribute = creature.attributes[attribute]
    @amount = amount
  end
  
  def apply!
    @attribute.increase(amount)
  end
end
