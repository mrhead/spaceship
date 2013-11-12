class QuadObject
  def draw(window)
    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color
    )
  end

  def x1
    x - width/2
  end

  def x2
    x + width/2
  end

  def y1
    y - height/2
  end

  def y2
    y + height/2
  end

  def out_of_screen?
    x2 < 0 ||
      x1 > Game::WIDTH ||
      y2 < 0 ||
      y1 > Game::HEIGHT
  end

  protected

  def color
    Gosu::Color::WHITE
  end

  def width
    raise NotImplementedError
  end

  def height
    raise NotImplementedError
  end
end
