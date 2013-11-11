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

    if button_down?(Gosu::KbLeft)
      @ship.left!
    end

    if button_down?(Gosu::KbRight)
      @ship.right!
    end

    if mouse_moved?
      @ship.set_x(mouse_x)
    end

    move_background
    move_missiles
    move_enemies
    find_collisions
    create_new_enemy
  end

  def button_down(key)
    if key == Gosu::KbSpace or key == Gosu::MsLeft
      @missiles << @ship.fire!
    end
  end

  def draw
    draw_background
    draw_ship
    draw_missiles
    draw_enemies
    draw_score
  end

  private

  def mouse_moved?
    @prev_mouse_x != mouse_x
  ensure
    @prev_mouse_x = mouse_x
  end

  def move_background
    @background.move!
  end

  def move_missiles
    @missiles.each do |missile|
      missile.move!
      if missile.out_of_screen?
        @missiles.delete(missile)
      end
    end
  end

  def move_enemies
    @enemies.each do |enemy|
      enemy.move!
      if enemy.out_of_screen?
        @enemies.delete(enemy)
      end
    end
  end

  def find_collisions
    @missiles.each do |missile|
      @enemies.each do |enemy|
        if missile.hit?(enemy)
          delete_enemy(enemy)
          delete_missile(missile)
          add_score(10)
        end
      end
    end
  end

  def delete_enemy(enemy)
    @enemies.delete(enemy)
  end

  def delete_missile(missile)
    @missiles.delete(missile)
  end

  def create_new_enemy
    if rand(100) == 0
      @enemies << Enemy.new
    end
  end

  def add_score(points)
    @score += points
  end

  def draw_background
    @background.draw(self)
  end

  def draw_ship
    @ship.draw(self)
  end

  def draw_missiles
    @missiles.each { |m| m.draw(self) }
  end

  def draw_enemies
    @enemies.each { |e| e.draw(self) }
  end

  def draw_score
    @font.draw("Score: #{@score}", WIDTH - 110, 10, 0)
  end
end

Game.run
