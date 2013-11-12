Hasu.load 'missile.rb'
Hasu.load 'quad_object.rb'

class Ship < QuadObject
  WIDTH = 20
  HEIGHT = 30
  STEP = 6

  attr_reader :x

  def initialize
    @x = Game::WIDTH/2
  end

  def draw(window)
    window.draw_triangle(
      x1, y2, color,
      x, y1, color,
      x2, y2, color
    )
  end

  def intersect?(enemy)
    x1 < enemy.x2 &&
      x2 > enemy.x1 &&
      y1 < enemy.y2 &&
      y2 > enemy.y1
  end

  def left!
    @x -= STEP

    if x1 < 0
      @x = 0
    end
  end

  def right!
    @x += STEP

    if x2 > Game::WIDTH
      @x = Game::WIDTH
    end
  end

  def set_x(x)
    @x = x
  end

  def fire!
    Missile.new(x, y)
  end

  def y
    Game::HEIGHT - HEIGHT - 20
  end

  private

  def color
    Gosu::Color::WHITE
  end

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
