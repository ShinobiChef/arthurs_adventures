# IDEA: give gold and potions weight. 
# maybe allow money notes or something later to carry more gold in a lighter way
class Artventures::Collectable
  include Sprite

  class_attributes :name, :weight, :worth

  def name
    self.class.class_attributes[:name] || self.class.name
  end

  def weight
    self.class.class_attributes[:weight] || 0
  end

  def worth
    self.class.class_attributes[:worth] || 0
  end
end