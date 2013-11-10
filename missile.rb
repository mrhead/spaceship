class Missile
  WIDTH = 2
  HEIGHT = 10
  SPEED = 8

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def move!
    @y -= SPEED
  end

  def draw(window)
    color = Gosu::Color::YELLOW

    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color
    )
  end

  private

  def x1
    x - WIDTH/2
  end

  def x2
    x + WIDTH/2
  end

  def y1
    y + HEIGHT
  end

  def y2
    y
  end
end
