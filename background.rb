Hasu.load 'star.rb'

class Background
  OBJECT_COUNT = 30

  attr_reader :stars

  def initialize
    @stars = []
    OBJECT_COUNT.times do
      @stars << Star.new
    end
  end

  def update
    update_stars
  end

  def draw(window)
    stars.each { |star| star.draw(window) }
  end

  private

  def update_stars
    stars.each(&:update)
  end
end
