# TODO: assign images below to corresponding Sprites declaratively, e.g. image "items/wizardred.png"
#
# @sprstatsbanner = Resource["data/backgrounds/statsbanner.png", true]

# Items are collectables that are not constantly active or have to be equipped and usually get destroyed after use
class Artventure::Item < Collectable

  # returns true if it should be destroyed
  def use_with(creature)
    effect!(creature) unless destroyed?
  end

  def destroyed?
    @destroyed
  end

  def destroy!
    @destroyed = true
  end
end