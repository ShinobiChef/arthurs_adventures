module Artventures
  # IDEA: give gold and potions weight. maybe allow money notes or something later to carry more gold in a lighter way
  class Collectable
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


  # Equipment is something you put on which has an permanent effect as long as it's active
  class Equipment < Collectable
    class_attributes :type
  
    def type
      self.class.class_attributes[:type]
    end    
  end


  # Items are collectables that are not constantly active or have to be equipped and usually get destroyed after use
  class Item < Collectable
    attr_reader :destroyed
  
    # returns true if it should be destroye
    def use(creature)
      effect!(creature) unless destroyed?
    end
  
    def destroyed?
      @destroyed ||= false
    end
  
    def destroy!
      @destroyed = true
    end    
  end
end