class Enemy
  WIDTH = 20
  HEIGHT = 20
  SPEED = 2

  attr_reader :x, :y

  def initialize
    @x = rand(Game::WIDTH - WIDTH*2) + WIDTH
    @y = -HEIGHT
  end

  def move!
    @y += SPEED
  end

  def draw(window)
    color = Gosu::Color::RED

    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color
    )
  end

  def out_of_screen?
    y > Game::HEIGHT
  end

  private

  def x1
    x - WIDTH/2
  end

  def x2
    x + WIDTH/2
  end

  def y1
    y
  end

  def y2
    y + HEIGHT
  end
end
