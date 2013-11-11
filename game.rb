require 'hasu'

Hasu.load 'ship.rb'
Hasu.load 'enemy.rb'
Hasu.load 'background.rb'

class Game < Hasu::Window
  WIDTH = 480
  HEIGHT = 640

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @background = Background.new
    @ship = Ship.new
    @missiles = []
    @enemies = []
    @score = 0
    @font = Gosu::Font.new(self, "Arial", 20)
  end

  def update
    @background.move!

    if button_down?(Gosu::KbLeft)
      @ship.left!
    end

    if button_down?(Gosu::KbRight)
      @ship.right!
    end

    if mouse_x != @prev_mouse_x
      @ship.set_x(mouse_x)
    end
    @prev_mouse_x = mouse_x

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
          @score += 10
        end
      end
    end

    if rand(100) == 0
      @enemies << Enemy.new
    end
  end

  def button_down(key)
    if key == Gosu::KbSpace or key == Gosu::MsLeft
      @missiles << @ship.fire!
    end
  end

  def draw
    @background.draw(self)
    @ship.draw(self)
    @missiles.each { |m| m.draw(self) }
    @enemies.each { |e| e.draw(self) }
    @font.draw("Score: #{@score}", WIDTH - 110, 10, 0)
  end
end

Game.run
