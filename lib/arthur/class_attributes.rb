# Useful for setting different default values across varying classes of the same super type.
#
# Example Usage:
# ==============
# class Creature
#   include ClassAttributes
#   class_attribute :attack, :defense
#   
#   def stats
#     puts self.class.name
#     puts self.class.class_attributes[:attack]
#     puts self.class.class_attributes[:defense]
#   end
# end
#
# class Rabbit < Creature
#   attack  1
#   defense 3
# end
#
# class Dragon < Creature
#   attack  10
#   defense 8
# end
#
# Rabbit.new.stats
# => Rabbit.class
# => 1
# => 3
#
# Dragon.new.stats
# => Rabbit.class
# => 10
# => 8

module ClassAttributes
  module ClassMethods
    def metaclass
      self.class
    end

    def class_attribute(*names)
      [names].flatten.each do |name|
        metaclass.instance_eval do
          define_method(name) do |value|
            @class_attributes ||= {}
            @class_attributes[name] = value
          end
        end
      end
    end
  
    def class_attributes
      @class_attributes
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end