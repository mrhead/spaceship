class Ship
  WIDTH = 30
  HEIGHT = 20
  STEP = 6

  attr_reader :x

  def initialize
    @x = Game::WIDTH/2
  end

  def draw(window)
    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color
    )
  end

  def left!
    @x -= STEP

    if x1 < 0
      @x = WIDTH/2
    end
  end

  def right!
    @x += STEP

    if x2 > Game::WIDTH
      @x = Game::WIDTH - WIDTH/2
    end
  end

  private

  def color
    Gosu::Color::WHITE
  end

  def y
    Game::HEIGHT - 10
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
    y - HEIGHT
  end
end
