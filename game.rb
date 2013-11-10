require 'hasu'

Hasu.load 'ship.rb'

class Game < Hasu::Window
  WIDTH = 480
  HEIGHT = 640

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @ship = Ship.new
  end

  def update
    if button_down?(Gosu::KbLeft)
      @ship.left!
    end

    if button_down?(Gosu::KbRight)
      @ship.right!
    end
  end

  def draw
    @ship.draw(self)
  end
end

Game.run
