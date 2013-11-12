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

  def fire(ship)
    Bomb.new(x, y, bomb_angle(ship))
  end

  def bomb_angle(ship)
    Gosu.angle(x, y, ship.x, ship.y)
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
end
