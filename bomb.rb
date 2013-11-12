class Bomb
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

  def move
    @x += Gosu.offset_x(angle, SPEED)
    @y += Gosu.offset_y(angle, SPEED)
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

  def out_of_screen?
    x < 0 ||
      x > Game::WIDTH ||
      y < 0 ||
      y > Game::HEIGHT
  end

  def x1
    x - WIDTH/2
  end

  def x2
    x + WIDTH/2
  end

  def y1
    y - HEIGHT/2
  end

  def y2
    y + HEIGHT/2
  end
end
