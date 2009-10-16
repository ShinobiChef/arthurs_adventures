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
    end
  end
end