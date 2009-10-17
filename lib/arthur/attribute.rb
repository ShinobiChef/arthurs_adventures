# A create has many attributes like health or mana
# TODO: experience could also be an Attribute
module Artventure
  
end
class Artventure::Creature
  # e.g. Health and Mana
  # maybe even Weight (to give a carrying limit, i.e. each item increases the weight)
  class Attribute
    attr_accessor :name, :max, :value
    
    def initialize(name, max = 0, value = max)
      @name, @max, @value = name, max, value
    end
    
    def increase(amount)
      return false if @value == @max
      
      @value += amount
      @value = @max if @value > @max
    end
    
    def decrease(amount)
      return false if @value == 0
      
      @value -= amount
      @value = 0 if @value < 0
    end
    
    def to_sym
      name.downcase.gsub(/[\s-]/, '_').to_sym
    end
    
    def to_s
      name
    end
    
    def to_i
      value
    end
    
    def to_f
      value.to_f
    end
  end


  # convencience methods available in Creature
  # e.g. @arthur.max_health
  module Attribute::Accessors
    module ClassMethods
      attr_accessor :health, :mana, :max_health, :max_mana
    end
    
    module InstanceMethods    
      def health
        @attributes[:health]
      end
  
      def mana
        @attributes[:mana]
      end

      def max_health
        @attributes[:health].max
      end
  
      def max_mana
        @attributes[:mana].max
      end
    end
    
    def self.included(base)
      base.include InstanceMethods
      base.extend ClassMethods
    end
  end
    
end