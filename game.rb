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
    @missiles = []
  end

  def update
    if button_down?(Gosu::KbLeft)
      @ship.left!
    end

    if button_down?(Gosu::KbRight)
      @ship.right!
    end

    @missiles.each do |missile|
      missile.move!
      if missile.out_of_screen?
        @missiles.delete(missile)
      end
    end
  end

  def button_down(key)
    if key == Gosu::KbSpace
      @missiles << @ship.fire!
    end
  end

  def draw
    @ship.draw(self)
    @missiles.each { |m| m.draw(self) }
  end
end

Game.run
