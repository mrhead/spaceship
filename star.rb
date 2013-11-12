class Star
  attr_reader :x, :y, :color, :speed, :size

  def initialize
    @x = rand_x
    @y = rand_y
    @color = Gosu::Color::GRAY
    @speed = rand + 0.5
    @size = rand(2) + 1
  end

  def update
    move
    if out_of_screen?
      set_new_position
    end
  end

  def draw(window)
    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color
    )
  end

  def out_of_screen?
    y1 > Game::HEIGHT
  end

  def x1
    x - size/2
  end

  def x2
    x + size/2
  end

  def y1
    y - size/2
  end

  def y2
    y + size/2
  end

  def size
    @size.to_f
  end

  private

  def rand_x
    rand(Game::WIDTH)
  end

  def rand_y
    rand(Game::HEIGHT)
  end

  def move
    @y += speed
  end

  def set_new_position
    @y = - rand(20)
    @x = rand_x
  end
end
