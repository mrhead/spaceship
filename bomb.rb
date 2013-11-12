Hasu.load 'quad_object.rb'

class Bomb < QuadObject
  WIDTH = 4
  HEIGHT = 4
  SPEED = 2

  attr_reader :x, :y, :angle

  def initialize(x, y, angle)
    @x = x
    @y = y
    @angle = angle
  end

  def update
    move
  end

  def out_of_screen?
    x < 0 ||
      x > Game::WIDTH ||
      y < 0 ||
      y > Game::HEIGHT
  end

  def width
    WIDTH
  end

  def height
    HEIGHT
  end

  private

  def move
    @x += Gosu.offset_x(angle, SPEED)
    @y += Gosu.offset_y(angle, SPEED)
  end

  def color
    Gosu::Color::YELLOW
  end
end
