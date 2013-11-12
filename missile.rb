Hasu.load 'quad_object.rb'

class Missile < QuadObject
  WIDTH = 4
  HEIGHT = 10
  SPEED = 8

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def update
    move
  end

  def hit?(enemy)
    x1 < enemy.x2 &&
      x2 > enemy.x1 &&
      y1 < enemy.y2 &&
      y2 > enemy.y1
  end

  def width
    WIDTH
  end

  def height
    HEIGHT
  end

  private

  def move
    @y -= SPEED
  end

  def color
    Gosu::Color::YELLOW
  end
end
