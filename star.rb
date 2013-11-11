class Star
  attr_reader :x, :y, :color, :speed, :size

  def initialize
    @x = rand_x
    @y = rand_y
    @color = Gosu::Color::GRAY
    @speed = rand + 0.5
    @size = rand(2) + 1
  end

  def move!
    @y += speed
    if y > Game::HEIGHT
      @y = - rand(20)
      @x = rand_x
    end
  end

  def draw(window)
    window.draw_quad(
      x, y, color,
      x, y+size, color,
      x+size, y+size, color,
      x+size, y, color
    )
  end

  private

  def rand_x
    rand(Game::WIDTH)
  end

  def rand_y
    rand(Game::HEIGHT)
  end
end
