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

  def color
    Gosu::Color::WHITE
  end

  def width
    raise NotImplementedError
  end

  def height
    raise NotImplementedError
  end

  def out_of_screen?
    raise NotImplementedError
  end
end
