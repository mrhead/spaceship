require 'hasu'

Hasu.load 'ship.rb'
Hasu.load 'enemy.rb'

class Game < Hasu::Window
  WIDTH = 480
  HEIGHT = 640

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @ship = Ship.new
    @missiles = []
    @enemies = []
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

    @enemies.each do |enemy|
      enemy.move!
      if enemy.out_of_screen?
        @enemies.delete(enemy)
      end
    end

    @missiles.each do |missile|
      @enemies.each do |enemy|
        if missile.hit?(enemy)
          @enemies.delete(enemy)
          @missiles.delete(missile)
        end
      end
    end

    if rand(100) == 0
      @enemies << Enemy.new
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
    @enemies.each { |e| e.draw(self) }
  end
end

Game.run
