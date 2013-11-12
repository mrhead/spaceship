Hasu.load 'bomb.rb'
Hasu.load 'quad_object.rb'

class Enemy < QuadObject
  WIDTH = 25
  HEIGHT = 25
  SPEED = 2

  attr_reader :x, :y

  def initialize
    @x = rand(Game::WIDTH - WIDTH*2) + WIDTH
    @y = -HEIGHT
  end

  def update
    move
  end

  def fire(target)
    Bomb.new(x, y, bomb_angle(target))
  end

  def out_of_screen?
    y > Game::HEIGHT
  end

  private

  def move
    @y += SPEED
  end

  def color
    Gosu::Color::RED
  end

  def width
    WIDTH
  end

  def height
    HEIGHT
  end

  def bomb_angle(target)
    Gosu.angle(x, y, target.x, target.y)
  end
end
